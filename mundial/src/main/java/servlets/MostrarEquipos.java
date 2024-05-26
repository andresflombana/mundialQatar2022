/**
 *
 * Authors: Andrés Lombana y Valentina Alvarez
 */
package servlets;

import com.mundo.mundial.Equipo;
import com.mundo.mundial.gestionarEquipos;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet(name = "MostrarEquipo", urlPatterns = {"/MostrarEquipo"})
public class MostrarEquipos extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String nombreEquipoSeleccionado = request.getParameter("equipo");
        List<Equipo> equipos = gestionarEquipos.leerEquiposDesdeArchivo(getServletContext());
        
        // Buscar el equipo seleccionado en la lista
        Equipo equipoSeleccionado = null;
        for (Equipo equipo : equipos) {
            if (equipo.getNombreEquipo().equals(nombreEquipoSeleccionado)) {
                equipoSeleccionado = equipo;
                break;
            }
        }
        
        // Mostrar los detalles del equipo seleccionado
        if (equipoSeleccionado != null) {
            PrintWriter out = response.getWriter();
            out.println("<h2>Detalles del Equipo</h2>");
            out.println("<div class='equipo-cell'>");
            out.println("<div class='equipo-background' style='background-image: url(\"" + equipoSeleccionado.getEscudo() + "\")'></div>");
            out.println("<div class='equipo-text'>");
            out.println("<p class='card-text'>" + equipoSeleccionado.getNombreEquipo() + "</p>");
            out.println("<p class='card-text'>Técnico: " + equipoSeleccionado.getDirector() + "</p>");
            out.println("</div>");
            out.println("</div>");
        } else {
            response.getWriter().println("<p>No se encontraron detalles para el equipo seleccionado.</p>");
        }
    }
}