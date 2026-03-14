import Cahier.Content
import Cahier.Web.Presenters.Blog qualified as Blog
import Cahier.Web.Presenters.Pages qualified as Pages
import Cahier.Web.Presenters.Poetry qualified as Poetry

import Cahier.Web.Logger (logStdoutCustom)
import Config (scottyOptions)
import Data.Text.Lazy qualified as TL
import Network.Wai.Middleware.Static
import Text.Blaze.Html (Html)
import Text.Blaze.Html.Renderer.Text qualified as R
import Web.Scotty

main :: IO ()
main = do
  -- Load content
  cache <- loadContentCache "content"

  -- Set logger and configuration
  logger <- logStdoutCustom
  opts <- scottyOptions

  scottyOpts opts do
    middleware $ staticPolicy (noDots >-> addBase "static")
    middleware logger

    get "/robots.txt" $ do
      setHeader "Content-Type" "text/plain"
      text robotsTxt

    get "/" $ render Pages.home

    get "/posts" $ render (Blog.list cache)
    get "/posts/:slug" do
      slug <- pathParam "slug"
      maybe next render (Blog.view slug cache)

    get "/poetry" $ render (Poetry.list cache)
    get "/poetry/:slug" do
      slug <- pathParam "slug"
      maybe next render (Poetry.view slug cache)

    get "/about" $ render Pages.about

    notFound $ render Pages.notFound

render :: Html -> ActionM ()
render = html . R.renderHtml

robotsTxt :: TL.Text
robotsTxt =
  TL.pack
    """
    User-agent: *
    Allow: /

    # ---------------------------
    # OpenAI
    # ---------------------------
    User-agent: GPTBot
    Disallow: /

    # ---------------------------
    # Google AI training
    # ---------------------------
    User-agent: Google-Extended
    Disallow: /

    # ---------------------------
    # Anthropic
    # ---------------------------
    User-agent: ClaudeBot
    Disallow: /

    # ---------------------------
    # Perplexity
    # ---------------------------
    User-agent: PerplexityBot
    Disallow: /

    # ---------------------------
    # Amazon AI
    # ---------------------------
    User-agent: Amazonbot
    Disallow: /

    # ---------------------------
    # Apple AI training
    # ---------------------------
    User-agent: Applebot-Extended
    Disallow: /

    # ---------------------------
    # ByteDance / TikTok
    # ---------------------------
    User-agent: Bytespider
    Disallow: /

    # ---------------------------
    # Common Crawl (many AI datasets)
    # ---------------------------
    User-agent: CCBot
    Disallow: /

    # ---------------------------
    # Meta / Facebook research crawlers
    # ---------------------------
    User-agent: FacebookBot
    Disallow: /

    User-agent: Meta-ExternalAgent
    Disallow: /

    # ---------------------------
    # AI dataset & scraping companies
    # ---------------------------
    User-agent: Diffbot
    Disallow: /

    User-agent: DataForSeoBot
    Disallow: /

    User-agent: ImagesiftBot
    Disallow: /

    User-agent: OAI-SearchBot
    Disallow: /

    # ---------------------------
    # Misc aggressive scrapers
    # ---------------------------
    User-agent: PetalBot
    Disallow: /

    User-agent: SemrushBot
    Disallow: /

    User-agent: AhrefsBot
    Disallow: /

    User-agent: MJ12bot
    Disallow: /

    User-agent: DotBot
    Disallow: /
    """
