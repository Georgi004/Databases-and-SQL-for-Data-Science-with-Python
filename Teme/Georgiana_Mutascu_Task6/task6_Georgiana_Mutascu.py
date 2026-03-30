
import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt

try:
    mydb = mysql.connector.connect(
        host = "127.0.0.1",
        user = "root",
        password = "python",
        database = "movies_db"
    )
    cursor = mydb.cursor()
    print("Conexiune la baza de date MySQL reusita!")
except mysql.connector.Error as err:
    print(f"Eroare de conexiune la baza de date: {err}")
    exit()

sql_query = """
SELECT
    g.name,
    m.budget
FROM movies m
JOIN movie_genres mg ON m.movie_id = mg.movie_id
JOIN genres g ON mg.genre_id = g.genre_id
"""

try:
    cursor.execute(sql_query)
    results = cursor.fetchall()
    column_names = [i[0] for i in cursor.description]
    cursor.close()
    mydb.close()
    print("Datele au fost preluate, conexiunea inchisa.")
except Exception as e:
    print(f"Eroare la executarea interogarii sau preluarea datelor:{e}")
    cursor.close()
    mydb.close()
    exit()

df = pd.DataFrame(results, columns = column_names)

if not df.empty:

    # Conditie 1
    df['budget'] = pd.to_numeric(df['budget'])

    # Conditie 2
    average_budget_by_genre = df.groupby('name')['budget'].mean().sort_values(ascending=False)
    print("\n--- Statistici de baza ale bugetului ---")
    print(df['budget'].describe())
    print("\n--- Bugetul Mediu al Filmului pe Gen ---")
    print(average_budget_by_genre)

    # Conditie 3
    plt.figure(figsize=(12, 6))
    average_budget_by_genre.plot(kind='bar', color='gold', edgecolor='black')
    plt.savefig('task6_chart_georgiana_mutascu.png')
    print("\nGraficul a fost salvat ca: task6_chart_georgiana_mutascu.png")
else:
    print("DataFrame-ul este gol. Verificati daca baza de date contine date.")
