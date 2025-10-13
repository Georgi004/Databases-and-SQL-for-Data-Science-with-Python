
import os
import argparse
import pandas as pd
from graphviz import Digraph


def analyze_csv(csv_path):
    pd.set_option('display.max_columns', 10)
    if os.path.exists(csv_path):
        df = pd.read_csv(csv_path)
        print("\n Primele coloane din fisierul CSV:")
        print(df.head())
        print("\nColoane disponibile:", list(df.columns))
    else:
        print(f"Fisierul {csv_path} nu a fost gasit. Se va genera modelul generic.")



def generate_conceptual_model(output_dir):
    conceptual = Digraph("Conceptual", format="png")
    conceptual.attr(rankdir="LR", bgcolor="white")

    conceptual.node("Movie", "Movie\n- movie_id (PK)\n- title\n- year\n- duration\n- budget\n- box_office")
    conceptual.node("Director", "Director\n- director_id (PK)\n- name")
    conceptual.node("Genre", "Genre\n- genre_id (PK)\n- name")
    conceptual.node("Country", "Country\n- country_id (PK)\n- name")
    conceptual.node("Language", "Language\n- language_id (PK)\n- name")

    conceptual.edge("Director", "Movie", label="1:N", color="blue")
    conceptual.edge("Genre", "Movie", label="M:N", color="green")
    conceptual.edge("Country", "Movie", label="1:N", color="orange")
    conceptual.edge("Language", "Movie", label="1:N", color="purple")

    conceptual.render(os.path.join(output_dir, "model_conceptual"), cleanup=True)
    print("Modelul conceptual a fost generat.")


def generate_logical_model(output_dir):
    logical = Digraph("Logical", format="png")
    logical.attr(rankdir="LR", bgcolor="white")


    logical.node("movies", "movies\n- movie_id INT PK\n- title VARCHAR(255)\n- year INT\n- duration INT\n- budget DECIMAL(15,2)\n- box_office DECIMAL(15,2)\n- director_id INT FK\n- country_id INT FK\n- language_id INT FK")
    logical.node("directors", "directors\n- director_id INT PK\n- name VARCHAR(255)")
    logical.node("genres", "genres\n- genre_id INT PK\n- name VARCHAR(100)")
    logical.node("countries", "countries\n- country_id INT PK\n- name VARCHAR(100)")
    logical.node("languages", "languages\n- language_id INT PK\n- name VARCHAR(100)")
    logical.node("movie_genres", "movie_genres\n- movie_id INT FK\n- genre_id INT FK\nPRIMARY KEY (movie_id, genre_id)")

    logical.edge("directors", "movies", label="1:N")
    logical.edge("countries", "movies", label="1:N")
    logical.edge("languages", "movies", label="1:N")
    logical.edge("movies", "movie_genres", label="1:N")
    logical.edge("genres", "movie_genres", label="1:N")

    logical.render(os.path.join(output_dir, "model_logical"), cleanup=True)
    print("Modelul logic a fost generat.")


def generate_sql_script(output_dir):
    sql = """-- Model logic SQL pentru baza de date "Movies"

CREATE TABLE directors (
    director_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE genres (
    genre_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE countries (
    country_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE languages (
    language_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    year INT,
    duration INT,
    budget DECIMAL(15,2),
    box_office DECIMAL(15,2),
    director_id INT,
    country_id INT,
    language_id INT,
    FOREIGN KEY (director_id) REFERENCES directors(director_id),
    FOREIGN KEY (country_id) REFERENCES countries(country_id),
    FOREIGN KEY (language_id) REFERENCES languages(language_id)
);

CREATE TABLE movie_genres (
    movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);
"""

    with open(os.path.join(output_dir, "ddl.sql"), "w", encoding="utf-8") as f:
        f.write(sql)
    print("Scriptul SQL a fost salvat in ddl.sql.")


def main():
    parser = argparse.ArgumentParser(description="Generare modele conceptuale si logice pentru baza de date movies")
    parser.add_argument("--csv", required=False, help="Fisierul CSV cu datele filmelor", default="movies.csv")
    parser.add_argument("--outdir", required=False, help="Directorul unde se salveaza fisierele generate", default="output")
    args = parser.parse_args()

    output_dir = args.outdir
    os.makedirs(output_dir, exist_ok=True)

    print(f"Directorul de iesire: {output_dir}")
    analyze_csv(args.csv)
    generate_conceptual_model(output_dir)
    generate_logical_model(output_dir)
    generate_sql_script(output_dir)


    print("\n Toate fisierele au fost generate cu succes in folderul:", output_dir)
    print(" model_conceptual.pdf")
    print(" model_logical.pdf")
    print(" ddl.sql")

if __name__ == "__main__":
    main()