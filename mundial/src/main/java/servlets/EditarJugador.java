/**
 *
 * Authors: Andrés Lombana y Valentina Alvarez
 */
package servlets;

import com.mundo.mundial.gestionarJugadores;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "EditarJugador", urlPatterns = {"/EditarJugador"})
public class EditarJugador extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String nombreJugador = request.getParameter("nombreJugador");
            int edad = Integer.parseInt(request.getParameter("edad"));
            double altura = Double.parseDouble(request.getParameter("altura"));
            double peso = Double.parseDouble(request.getParameter("peso"));
            double salario = Double.parseDouble(request.getParameter("salario"));
            String posicion = request.getParameter("posicion");
            String foto = request.getParameter("foto");
            String NombreEquipo = request.getParameter("NombreEquipo");

            // Llamando al método para Modificar Jugadores
            gestionarJugadores.modificarJugadores(nombreJugador, edad, altura, peso, salario, posicion, foto, NombreEquipo);

            // Redireccionar de vuelta al index.jsp
            request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}