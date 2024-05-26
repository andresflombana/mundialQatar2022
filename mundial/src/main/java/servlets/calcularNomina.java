/**
 *
 * Authors: Andrés Lombana y Valentina Alvarez
 */
package servlets;

import com.mundo.mundial.gestionarEquipos;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "calcularNomina", urlPatterns = {"/calcularNomina"})
public class calcularNomina extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String nombreEquipo = request.getParameter("nombreEquipo");
            if (nombreEquipo == null || nombreEquipo.isEmpty()) {
                out.println("Seleccione un equipo para calcular la nómina.");
                return;
            }

            boolean jugadoresRegistrados = gestionarEquipos.verificarJugadoresRegistrados(nombreEquipo, getServletContext());
            if (!jugadoresRegistrados) {
                out.println("El equipo seleccionado no tiene jugadores registrados.");
                return;
            }

            double totalSalario = gestionarEquipos.calcularNomina(nombreEquipo, getServletContext());
            out.println("La nómina del equipo seleccionado es: " + totalSalario);
        } catch (Exception e) {
            response.getWriter().println("Ocurrió un error al calcular la nómina.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet que calcula la nómina de un equipo";
    }
}
