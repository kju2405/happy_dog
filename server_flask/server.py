from flask import Flask,request,jsonify,url_for
from http import HTTPStatus
import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity

app = Flask(__name__)


routeList=[]
recommendList=[]
 
def clean_data(x):
    if isinstance(x,str):
        return x.replace(' ','')

#빈칸을 기준으로 다 합치는 작업
def create_soup(x):
    return x['walkKind']+' '+x['walkLevel']+' '+x['minutesWord']+' '+x['keyword1']+' '+x['keyword2']

def get_recommendations(cosine_sim):
    sim_scores=list(enumerate(cosine_sim[0]))
    sim_scores=sorted(sim_scores,key=lambda x:x[1], reverse=True)
    sim_scores=sim_scores[:5]
    routes_indices=[i[0] for i in sim_scores]
    return routes_indices


@app.route('/recommendroutes',methods=['POST'])
def recommend():
    print(request.is_json)
    params=request.get_json()
    # routeList.append(params['routeList'])
    routeList=params['routeList']
    print(params)
    print('-------------')
    print(routeList)
    df = pd.DataFrame(routeList)
    features =['keyword1','keyword2']
    for feature in features:
        df[feature]=df[feature].apply(clean_data)
    df['soup']=df.apply(create_soup,axis=1)
    
    count=CountVectorizer()
    count_matrix=count.fit_transform(df['soup'])
    # print(count_matrix)
    input=[]
    if params['walkingTime']==1:
        input.append('VERYLOW')
    elif params['walkingTime']==2:
        input.append('LOW')
    elif params['walkingTime']==3:
        input.append('MIDDLE')
    elif params['walkingTime']==4:
        input.append('HIGH')
    else:
        input.append('TOOHIGH')

    if params['walkingLevel']==1:
        input.append('EASY')
    elif params['walkingLevel']==2:
        input.append('NORMAL')
    else:
        input.append('HARD')
    
    if params['walkingType']==1:
        input.append('WALK')
    elif params['walkingType']==2:
        input.append('RUN')
    else:
        input.append('CLIMB')
    input.append(params['keyword1'].replace(' ',''))
    input.append(params['keyword2'].replace(' ',''))
    input=[' '.join(input)]
    input_matrix=count.transform(input)
    cosine_sim=cosine_similarity(input_matrix,count_matrix)
    routes_indices=get_recommendations(cosine_sim)
    recommendList=routes_indices
    print(input)
    print(df['soup'])
    print(cosine_sim)
    print(routes_indices)
    print(recommendList)

    return 'ok'
 
 
app.run(host='0.0.0.0',port='5001' ,debug=True)