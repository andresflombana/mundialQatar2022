/**
 *
 * Authors: Andrés Lombana y Valentina Alvarez
 */
package com.mundo.mundial;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletContext;

public class gestionarEquipos {

   // Contenedor de Equipos
    private static ArrayList<Equipo> misEquipos = new ArrayList<>();

    // Constructor vacío
    public gestionarEquipos() {
        // Puedes inicializar la lista aquí si lo deseas
    }

    // Método para escribir los equipos en un archivo
    public static void escribirEquiposEnArchivo(ArrayList<Equipo> misEquipos, ServletContext context) {
        String rutaRelativa = "data/equipos.txt";
        String rutaAbsoluta = context.getRealPath(rutaRelativa);
        File archivo = new File(rutaAbsoluta);

        try (PrintWriter writer = new PrintWriter(new FileWriter(archivo))) {
            for (Equipo miEquipo : misEquipos) {
                writer.println(miEquipo.getNombreEquipo() + "," + miEquipo.getDirector() + "," + miEquipo.getEscudo());
            }
        } catch (IOException e) {
            System.out.println("No se puede escribir en el archivo: " + e.getMessage());
        }
    }

    // Método para leer los equipos desde un archivo
    public static ArrayList<Equipo> leerEquiposDesdeArchivo(ServletContext context) {
        ArrayList<Equipo> equipos = new ArrayList<>();
        String rutaRelativa = "data/equipos.txt";
        String rutaAbsoluta = context.getRealPath(rutaRelativa);
        File archivo = new File(rutaAbsoluta);

        try (BufferedReader reader = new BufferedReader(new FileReader(archivo))) {
            String linea;
            while ((linea = reader.readLine()) != null) {
                // Divide la línea en campos separados por comas
                String[] campos = linea.split(",");
                if (campos.length == 3) { // Asegura que la línea tiene la estructura correcta
                    String nombreEquipo = campos[0];
                    String director = campos[1];
                    String escudo = campos[2];
                    // Crea un nuevo objeto Equipo y agrégalo al ArrayList
                    equipos.add(new Equipo(nombreEquipo, director, escudo));
                }
            }
        } catch (IOException e) {
            System.out.println("No se puede leer el archivo: " + e.getMessage());
        }

        return equipos;
    }

    // Método para agregar un equipo
    public static ArrayList<Equipo> agregarEquipo(String nombreEquipo, String director, String escudo, ArrayList Equipos) {
        Equipo miEquipo = new Equipo(nombreEquipo, director, escudo);
        
        Equipos.add(miEquipo);
        
        return Equipos;
    }

    // Método para eliminar un equipo
    public static void eliminarEquipo(String nombreEquipo, ServletContext context) {
        ArrayList<Equipo> misEquipos = leerEquiposDesdeArchivo(context);

        for (Equipo equipo : misEquipos) {
            if (equipo.getNombreEquipo().equals(nombreEquipo)) {
                misEquipos.remove(equipo);
                break;
            }
        }

        escribirEquiposEnArchivo(misEquipos, context);
    }

    // Método para editar un equipo por su nombre


    public static boolean verificarJugadoresRegistrados(String nombreEquipo, ServletContext context) {
        ArrayList<Jugador> jugadores = gestionarJugadores.leerJugadoresDesdeArchivo(context);
        for (Jugador jugador : jugadores) {
            if (jugador.getNombreEquipo().equals(nombreEquipo)) {
                return true;
            }
        }
        return false;
    }

    public static double calcularNomina(String nombreEquipo, ServletContext context) {
        ArrayList<Jugador> jugadores = gestionarJugadores.leerJugadoresDesdeArchivo(context);
        double totalSalario = 0;
        for (Jugador jugador : jugadores) {
            if (jugador.getNombreEquipo().equals(nombreEquipo)) {
                totalSalario += jugador.getSalario();
            }
        }
        return totalSalario;
    }
}

