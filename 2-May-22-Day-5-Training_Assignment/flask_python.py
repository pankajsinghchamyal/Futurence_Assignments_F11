import flask
from flask import request,jsonify
app = flask.Flask(__name__)
app.config["DEBUG"] = True

books = [{
    'id':0,
    'title':'A Fire Upon the Deep',
    'author':'Vernor vinge',
    'first_sentence':'The coldsleep itself was dreamless.',
    'year_published':'1992'},{
    'id':1,
    'title':'the ones who walk away from omelas',
    'author':'Ursula K. Le Guin',
    'first_sentence':'With a clamor of bells that set the swallows soaring the festivaL OF SUMMER JCAME TO THE CTIY LOMELAS, BRIGHT',
    'year_published':'1973'},{
    'id':2,
    'title':'Dhalgren',
    'author':'Samuel R. Delany',
    'first_sentence':'To wound the autumnal city.',
    'year_published':'1975'}]

@app.route('/', methods =['Get'])
def home():
    return 'hello to my api'
@app.route('/books/all',methods=['GET'])
def api_all():
           return jsonify(books)
    
app.run()