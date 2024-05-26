<%-- 
    Document   : index
    Authors    : Andrés Lombana y Valentina Alvarez
--%>

<%@page import="com.mundo.mundial.gestionarEquipos"%>
<%@page import="com.mundo.mundial.Equipo"%>
<%@ page import="java.util.List"%>
<%@ include file="lib/header.jsp" %>

<!-- T�tulo -->
<div class="container sepa">
    <div class="row">
        <div class="col-md-12">
            <div class="title-container sepa">
                <center><p>EQUIPOS</p></center>
            </div>
        </div>
    </div>
</div>

<!-- Selecci�n de Equipo -->
<div class="text1-container">
    <div class="row justify-content-center">
        <div class="col-md-6 mb-4">
            <p>Seleccionar Equipo</p>
            <form id="equipoForm">
                <div class="select-container">
                    <select name="equipo" id="equipoSelect" class="select-style">
                        <option class="select-style option" disabled selected>Selecciona un equipo</option>
                        <% 
                            List<Equipo> equipos = gestionarEquipos.leerEquiposDesdeArchivo(getServletContext());
                            if (equipos != null && !equipos.isEmpty()) {
                                for (Equipo equipo : equipos) {
                        %>
                        <option class="select-style option" value="<%= equipo.getNombreEquipo() %>">
                            <%= equipo.getNombreEquipo() %>
                        </option>
                        <% 
                                }
                            } 
                        %>
                    </select>
                </div>
            </form>
        </div>

        <div class="col-md-6 mb-4">
            <div id="detallesEquipo" style="text-align: center;">
                <!-- Aqu� se mostrar�n los detalles del equipo seleccionado -->
            </div>
        </div>
    </div>
</div>

<!-- Enlaces a JavaScript y jQuery-->
<script>
    document.getElementById('equipoSelect').addEventListener('change', function () {
        var equipoForm = document.getElementById('equipoForm');
        var formData = new FormData(equipoForm);

        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    document.getElementById('detallesEquipo').innerHTML = xhr.responseText;
                } else {
                    console.error('Error al cargar detalles del equipo');
                }
            }
        };
        xhr.open('GET', 'MostrarEquipo?' + new URLSearchParams(formData).toString(), true);
        xhr.send();
    });
</script>

<%@ include file="lib/footer.jsp" %>
