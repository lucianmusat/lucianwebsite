from fastapi import FastAPI, Request
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates

app = FastAPI(
    title="Lucian's Website",
    description="A basic presentation site for Lucian's projects",
)

app.mount("/static", StaticFiles(directory="static"), name="static")
templates = Jinja2Templates(directory="templates")


@app.get("/")
async def root(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})


@app.get("/resume")
async def root(request: Request):
    return templates.TemplateResponse("resume.html", {"request": request})


@app.get("/contact")
async def root(request: Request):
    return templates.TemplateResponse("contact.html", {"request": request,
               "message": """No boring old contact form here!<br /><br />You can contact me at 
               <a href="mailto:lucian.musat@hotmail.com">lucian.musat@hotmail.com</a> or check out my 
               <a href="https://www.linkedin.com/in/lucian-musat/" target="_blank">LinkedIn</a>
                or <a href="https://github.com/lucianmusat" target="_blank">GitHub</a> profiles."""})


@app.exception_handler(404)
async def custom_404_handler(request, __):
    return templates.TemplateResponse("contact.html", {"request": request,
                                                       "message": "Not sure what you are looking for, but it's not here!"})
