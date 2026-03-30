
import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns 

# 1. Conexiunea la baza de date
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

# 2. Punctul 1 - Analiza genurilor (Cele mai mari castiguri)
print("\n---------------------------------------------------")
print("--- 1. Analiza Genurilor (Top 3 Castiguri Totale) ---")
print("\n---------------------------------------------------")

sql_query_genres = """
SELECT 
    g.name AS genre_name,
    SUM(m.box_office) AS total_revenue
FROM movies m
JOIN movie_genres mg ON m.movie_id = mg.movie_id
JOIN genres g ON mg.genre_id = g.genre_id
GROUP BY g.name
ORDER BY total_revenue DESC
LIMIT 3;
"""

try:
    top_genres_df = pd.read_sql(sql_query_genres, mydb)
    print("\n--- Top 3 Genuri dupa castigul total (Revenue) ---")
    print(top_genres_df)
    plt.figure(figsize=(10, 6))
    sns.barplot(x='total_revenue', y='genre_name', data=top_genres_df, hue='genre_name', palette='magma', legend=False)
    plt.title('Top 3 Genuri dupa Castigul Total (Revenue)')
    plt.xlabel('Castig Total ($)')
    plt.ylabel('Gen')
    plt.ticklabel_format(style='plain', axis='x')
    plt.savefig('task6_barchart_genres.png')
    print("Graficul a fost salvat ca: task6_barchart_genres.png")
    print("\nRecomandare: Investiti in genurile listate mai sus, care demonstreaza cel mai mare potential de catsig total.")
except Exception as e:
    print(f"Eroare la Punctul 1: {e}")

# 3. Punctul 2 - Legatura dintre buget si castiguri
print("\n---------------------------------------------")
print("\n--- 2. Legatura dintre Buget si Castiguri ---")
print("\n---------------------------------------------")

# Preluarea datelor pentru Scatter Plot si Corelatie
sql_query_budget_revenue = """
SELECT budget, box_office AS revenue FROM movies WHERE budget > 0 AND box_office > 0
"""

try:
    movies_df = pd.read_sql(sql_query_budget_revenue, mydb)

    if not movies_df.empty:

        # Calcularea corelatiei Pearson
        correlation = movies_df[['budget', 'revenue']].corr().iloc[0, 1]
        print(f"Corelatia Pearson intre buget si castig: {correlation:.2f}")

        # Crearea Scatter Plot-ului
        plt.figure(figsize=(10, 6))
        plt.scatter(movies_df['budget'], movies_df['revenue'], alpha=0.5, color='blue')
        plt.title('Relatia dintre Buget si Castigul Filmului')
        plt.xlabel('Buget ($)')
        plt.ylabel('Castig ($)')
        plt.ticklabel_format(style='plain', axis='both')
        plt.grid(True)
        plt.savefig('task6_scatter_budget_revenue.png')
        print("Graficul a fost salvat ca: task6_scatter_budget_revenue.png")

        # Analiza
        print("\nAnaliza:")
        print(f"- Corelatia de {correlation:.2f} indica o legatura pozitiva moderata/puternica.")
        print("- Un buget mai mare tinde sa aduca un castig mai mare, dar nu garanteaza succesul (din cauza outlier-ilor).")
    else:
        print("Nu s-au gasit date valide pentru Buget si Castiguri.")
except Exception as e:
    print(f"Eroare la Punctul 2: {e}")

# 4. Punctul 3: Analiza tarilor de productie
print("\n---------------------------------------------")
print("--- 3. Analiza Tarilor (Top 5 Castig Mediu) ---")
print("\n---------------------------------------------")

sql_query_countries = """
SELECT
    c.name AS country_name,
    AVG(m.box_office) AS average_revenue
FROM movies m
JOIN movies_countries mc ON m.movie_id = mc.movie_id
JOIN countries c ON mc.country_id = c.country_id
WHERE m.box_office > 0
GROUP BY c.name
ORDER BY average_revenue DESC
LIMIT 5;
"""
try:
    top_countries_df = pd.read_sql(sql_query_countries, mydb)

    print("\n--- Top 5 Tari dupa Castigul Mediu pe Film ---")
    print(top_countries_df)

    # Crearea Bar Chart-ului cu Seaborn
    plt.figure(figsize=(10, 6))
    sns.barplot(x='average_revenue', y='country_name', data=top_countries_df, hue='country_name', palette='viridis', legend=False)
    plt.title('Top 5 Tari dupa Castigul Mediu pe Film')
    plt.xlabel('Castig Mediu ($)')
    plt.ylabel('Tara')
    plt.ticklabel_format(style='plain', axis='x')
    plt.savefig('task6_barchart_countries.png')
    print("Graficul a fost salvat ca: task6_barchart_countries.png")
    print("\nRecomandare: Investiti in productia de filme in tarile listate, deoarece au cel mai mare castig mediu per film.")

except Exception as e:
    print(f"Eroare la Punctul 3: {e}")

# 5. Punctul 4: Cele mai de succes filme
print("\n----------------------------------------------")
print("--- 4. Top 10 Filme dupa Castiguri (Revenue) ---")
print("\n----------------------------------------------")

sql_query_top_movies = """
SELECT DISTINCT
    title,
    box_office AS revenue
FROM movies
ORDER BY revenue DESC
LIMIT 10;
"""
try:
    top_movies_df = pd.read_sql(sql_query_top_movies, mydb)
    print(top_movies_df)
    plt.figure(figsize=(10, 6))
    sns.barplot(x='revenue', y='title', data=top_movies_df, hue='title', palette='Spectral', legend=False)
    plt.title('Top 10 Filme dupa Castiguri (Revenue)')
    plt.xlabel('Castig ($)')
    plt.ylabel('Titlu Film')
    plt.ticklabel_format(style='plain', axis='x')
    plt.savefig('task6_barchart_top_movies.png')
    print("Graficul a fost salvat ca: task6_barchart_top_movies.png")

except Exception as e:
    print(f"Eroare la Punctul 4: {e}")

# 6. Inchiderea conexiunii
try:
    cursor.close()
    mydb.close()
    print("\nConexiunea la baza de date a fost inchisa.")
except Exception as e:
    print(f"Eroare la inchiderea conexiunii: {e}")