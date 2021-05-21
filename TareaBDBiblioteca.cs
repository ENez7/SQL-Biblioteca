using Microsoft.Data.SqlClient;
using System;

namespace EjercicioEnClase
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Conexion con base de datos");
            string connString = "Data Source=DESKTOP-S5G74PE;Initial Catalog=Exam2Verif;Integrated Security=True";
            SqlConnection sqlConnection = new SqlConnection(connString);
            SqlDataReader sqlDataReader = null;

            try
            {
                Console.WriteLine("Abriendo conexion...");
                sqlConnection.Open();
                Console.WriteLine("Conectado");
            }catch(Exception e)
            {
                Console.WriteLine("Error: " + e.Message);
                Environment.Exit(0);
            }

            // OBTENER DATOS
            String libro = "", autor = "";
            obtenerDatos(ref libro, ref autor);

            // VERIFICAR EXISTENCIA DEL LIBRO
            bool existeIDLibro = existeLibro(libro, sqlConnection, ref sqlDataReader);  // ref -> & (C++)
            sqlDataReader.Close();
            if (existeIDLibro)
                Console.WriteLine("LIBRO ENCONTRADO");
            else
            {
                // DEBERIA REGISTRAR LIBRO
                Console.WriteLine("LIBRO NO ENCONTRADO");
                Console.WriteLine("----------Registrando libro----------");
                registrarLibro(libro, sqlConnection, ref sqlDataReader);
                sqlDataReader.Close();
            }

            // VERIFICAR EXISTENCIA DE AUTORES
            String[] autores = autor.Split(' ');  // ALMACENAR TODOS LOS AUTORES

            foreach(String aut in autores)
            {
                if (!sqlDataReader.IsClosed)
                    sqlDataReader.Close();
                if (!existeAutor(aut, sqlConnection, ref sqlDataReader))
                {
                    sqlDataReader.Close();  // REGISTRAR EN CASO DE QUE NO EXISTA
                    registrarAutor(aut, sqlConnection, ref sqlDataReader);
                }
            }

            // VERIFICAR AUTORIAS
            foreach(String aut in autores)
            {
                if(!verificarAutoria(aut, libro, sqlConnection, ref sqlDataReader))
                {
                    // REGISTRAR AUTORIA EN CASO DE QUE NO EXISTA
                    sqlDataReader.Close();
                    registrarAutoria(aut, libro, sqlConnection, ref sqlDataReader);
                    sqlDataReader.Close();
                }
                    
            }

            sqlDataReader.Close();
            SqlCommand command = new SqlCommand("select * from Autorias", sqlConnection);
            sqlDataReader = command.ExecuteReader();
            
            while (sqlDataReader.Read())
                Console.WriteLine($"Autor: {sqlDataReader["IdAutor"]} Libro: {sqlDataReader["IdLibro"]}");
            sqlDataReader.Close();

        }

        static void obtenerDatos(ref String libro, ref String autor)
        {
            Console.WriteLine("IDLibro: ");
            libro = Console.ReadLine().ToUpper();
            Console.WriteLine("Autor: ");
            autor = Console.ReadLine().ToUpper();
        }
        // FUNCIONES LIBRO
        static bool existeLibro(String idLibro, SqlConnection sqlConnection, ref SqlDataReader sqlDataReader)
        {
            SqlCommand command = new SqlCommand($"select * from Libros where IdLibro = '{idLibro}'", sqlConnection);
            sqlDataReader = command.ExecuteReader();
            return sqlDataReader.HasRows;
        }

        static void registrarLibro(String idLibro, SqlConnection sqlConnection, ref SqlDataReader sqlDataReader)
        {
            // MODELO -> insert into Libros values ('L1','Amanecer','Infragante','Alfaguara','Literatura','1999','300','1 Edicion')
            Console.WriteLine("Titulo: ");
            String titulo = Console.ReadLine();

            Console.WriteLine("Subtitulo: ");
            String subTitulo = Console.ReadLine();

            Console.WriteLine("Editorial: ");
            String editorial = Console.ReadLine();

            Console.WriteLine("Area: ");
            String area = Console.ReadLine();

            Console.WriteLine("Año de publicacion: ");
            String publicacion = Console.ReadLine();

            Console.WriteLine("Paginas: ");
            String paginas = Console.ReadLine();

            Console.WriteLine("Edicion: ");
            String edicion = Console.ReadLine();

            SqlCommand command = new SqlCommand($"insert into Libros values('{idLibro}', '{titulo}', '{subTitulo}', '{editorial}', '{area}', '{publicacion}', '{paginas}', '{edicion}')", sqlConnection);
            sqlDataReader = command.ExecuteReader();
            sqlDataReader.Close();
        }
        // FUNCIONES AUTORES
        static bool existeAutor(String idAutor, SqlConnection sqlConnection, ref SqlDataReader sqlDataReader)
        {
            if (!sqlDataReader.IsClosed)
                sqlDataReader.Close();
            SqlCommand command = new SqlCommand($"select * from Autores where IdAutor = '{idAutor}'", sqlConnection);
            sqlDataReader = command.ExecuteReader();
            return sqlDataReader.HasRows;
        }

        static void registrarAutor(String idAutor, SqlConnection sqlConnection, ref SqlDataReader sqlDataReader)
        {
            if (!sqlDataReader.IsClosed)
                sqlDataReader.Close();
            Console.WriteLine($"ID Autor: {idAutor}");
            
            Console.WriteLine("Nombre: ");
            String nombre = Console.ReadLine();

            Console.WriteLine("Nacionalidad: ");
            String nacionalidad = Console.ReadLine();

            SqlCommand command = new SqlCommand($"insert into Autores values('{idAutor}', '{nombre}', '{nacionalidad}')", sqlConnection);
            sqlDataReader = command.ExecuteReader();
            sqlDataReader.Close();
        }

        // FUNCIONES AUTORIAS
        static bool verificarAutoria(String idAutor, String idLibro, SqlConnection sqlConnection, ref SqlDataReader sqlDataReader)
        {
            if (!sqlDataReader.IsClosed)
                sqlDataReader.Close();
            SqlCommand command = new SqlCommand($"select * from Autorias where IdAutor = '{idAutor}' and IdLibro = '{idLibro}'", sqlConnection);
            sqlDataReader = command.ExecuteReader();
            return sqlDataReader.HasRows;
        }

        static void registrarAutoria(String idAutor, String idLibro, SqlConnection sqlConnection, ref SqlDataReader sqlDataReader)
        {
            if (!sqlDataReader.IsClosed)
                sqlDataReader.Close();
            SqlCommand command = new SqlCommand($"insert into Autorias values('{idAutor}', '{idLibro}')", sqlConnection);
            sqlDataReader = command.ExecuteReader();
            sqlDataReader.Close();
        }
    }
}