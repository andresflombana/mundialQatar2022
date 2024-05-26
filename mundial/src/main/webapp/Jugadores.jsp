<%-- 
    Document   : index
    Authors    : AndrÈs Lombana y Valentina Alvarez
--%>

<%@page import="com.mundo.mundial.gestionarEquipos"%>
<%@page import="com.mundo.mundial.Equipo"%>
<%@page import="java.util.List"%>
<%@include file="lib/header.jsp" %>

<div class="container sepa">
    <div class="row">
        <!-- Tùtulo -->
        <div class="col-md-12">
            <div class="titel-container sepa">
                <center><p>JUGADORES</p></center>
            </div>
        </div>
    </div>
</div>

<div class="text1-container">
    <div class="row justify-content-center">
        <!-- Desplegable de Equipos -->
        <div class="col-md-6 mb-4">
            <form id="equipoForm">
                <label for="equipo">Seleccionar Equipo</label>
                <div class="select-container">
                    <select name="equipo" id="equipoSelect" class="select-style">
                        <option value="" disabled selected>Selecciona un equipo</option>
                        <% List<Equipo> equipos = gestionarEquipos.leerEquiposDesdeArchivo(getServletContext());
                            if (equipos != null && !equipos.isEmpty()) {
                                for (Equipo equipo : equipos) {
                        %>
                        <option value="<%=equipo.getNombreEquipo()%>"><%=equipo.getNombreEquipo()%></option>
                        <% }
                            } %>
                    </select>
                </div>
            </form>
        </div>
    </div>
</div>

<div id="jugadoresContainer" class="container sepa">
    <!-- Aquù se mostrarùn los jugadores del equipo seleccionado -->
</div>

<!-- Enlaces a JavaScript y jQuery-->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $('#equipoSelect').change(function() {
            var equipoSeleccionado = $(this).val();

            $.getJSON('MostrarJugadores', {equipo: equipoSeleccionado}, function(data) {
                var jugadoresHtml = '<h2>Jugadores del Equipo: ' + equipoSeleccionado + '</h2><ul>';
                $.each(data, function(index, jugador) {
                    jugadoresHtml += '<li>';
                    jugadoresHtml += '<strong>Nombre:</strong> ' + jugador.nombreJugador + '<br>';
                    jugadoresHtml += '<strong>Edad:</strong> ' + jugador.edad + '<br>';
                    jugadoresHtml += '<strong>Altura:</strong> ' + jugador.altura + '<br>';
                    jugadoresHtml += '<strong>Peso:</strong> ' + jugador.peso + '<br>';
                    jugadoresHtml += '<strong>Salario:</strong> ' + jugador.salario + '<br>';
                    jugadoresHtml += '<strong>Posiciùn:</strong> ' + jugador.posicion + '<br>';
                    jugadoresHtml += '</li>';
                });
                jugadoresHtml += '</ul>';
                $('#jugadoresContainer').html(jugadoresHtml);
            });
        });
    });
</script>

<%@include file="lib/footer.jsp" %>
