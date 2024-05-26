/**
 *
 * Authors: Andrés Lombana y Valentina Alvarez
 */
package servlets;

import com.google.gson.Gson;
import com.mundo.mundial.Jugador;
import com.mundo.mundial.gestionarJugadores;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "MostrarJugadores", urlPatterns = {"/MostrarJugadores"})
public class MostrarJugadores extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        // Obtener el nombre del equipo seleccionado desde los parámetros de la solicitud
        String nombreEquipoSeleccionado = request.getParameter("equipo");

        // Obtener la lista de jugadores del equipo seleccionado
        ArrayList<Jugador> jugadores = gestionarJugadores.leerJugadoresDesdeArchivo(getServletContext());

        // Filtrar la lista de jugadores para obtener solo aquellos que pertenecen al equipo seleccionado
        ArrayList<Jugador> jugadoresEquipoSeleccionado = new ArrayList<>();
        for (Jugador jugador : jugadores) {
            if (jugador.getNombreEquipo().equals(nombreEquipoSeleccionado)) {
                jugadoresEquipoSeleccionado.add(jugador);
            }
        }

        // Convertir la lista de jugadores a formato JSON
        Gson gson = new Gson();
        String jsonJugadores = gson.toJson(jugadoresEquipoSeleccionado);

        // Enviar la respuesta JSON al cliente
        PrintWriter out = response.getWriter();
        out.println(jsonJugadores);
    }
}
