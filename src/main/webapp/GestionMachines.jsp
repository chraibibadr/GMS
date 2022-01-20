<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Gestion des machines</title>
<script src="script/jquery-3.3.1.min.js" type="text/javascript"></script>
<link rel="stylesheet"
	href="assets/vendors/mdi/css/materialdesignicons.min.css">
<link rel="stylesheet" href="assets/vendors/css/vendor.bundle.base.css">
<link rel="stylesheet"
	href="assets/vendors/jvectormap/jquery-jvectormap.css">
<link rel="stylesheet"
	href="assets/vendors/flag-icon-css/css/flag-icon.min.css">
<link rel="stylesheet"
	href="assets/vendors/owl-carousel-2/owl.carousel.min.css">
<link rel="stylesheet"
	href="assets/vendors/owl-carousel-2/owl.theme.default.min.css">
<link rel="stylesheet" href="assets/css/style.css">
<link rel="shortcut icon" href="assets/images/favicon.png" />
</head>

<body>
	<div class="container-scroller">
		<%@include file="template/menu.jsp"%>
		<div class="container-fluid page-body-wrapper">
			<%@include file="template/header.jsp"%>
			<div class="main-panel">
				<div id="content" class="content-wrapper">
					<!-- Content start -->
					<div class="row">
						<div class="col-8 m-auto">
							<div class="card">
								<div class="card-body">
									<h4 class="card-title text-center">Ajouter une machine</h4>
									<div class="row">
										<div style="display:none" id="alertMachine" class="alert alert-danger alert-dismissible fade show col-12" role="alert">
										  <strong>!</strong> Tous les champs sont obligatoires
										  <button type="button" class="close" onclick="hide()">
										    <span aria-hidden="true">&times;</span>
										  </button>
										</div>
										<div class="form-group col-6">
											<label>Référence</label> 
											<input id="reference" name="reference" type="text" class="form-control p_input">
										</div>
										<div class="form-group col-6">
											<label>Marque</label> 
											<input id="marque" name="marque" type="text" class="form-control p_input">
										</div>
										<div class="form-group col-6">
											<label>Date d'achat</label> 
											<input id="dateAchat" name="dateAchat" type="date" class="form-control p_input">
										</div>
										<div class="form-group col-6">
											<label>Prix</label> 
											<input id="prix" name="prix" type="text" class="form-control p_input">
										</div>
										<div class="form-group col-10 mx-auto">
											<label>Salle</label> 
											<select id="salle" name="salle" class="form-control text-white">
												<option>Selectionner la salle</option>
											</select>
										</div>
										<div class="text-center col-6 m-auto">
											<button type="button" class="btn btn-success btn-block enter-btn" onclick="ajouterMachine()">Ajouter</button>
										</div>
									</div>	
								</div>
							</div>
						</div>
						<div class="col-lg-12 grid-margin stretch-card mt-2">
							<div class="card">
								<div class="card-body">
									<h4 class="card-title">Liste des machines</h4>
									<div class="table-responsive text-center">
										<table class="table">
											<thead>
												<tr>
													<th class="text-white">ID</th>
													<th class="text-white">Référence</th>
													<th class="text-white">Marque</th>
													<th class="text-white">Date d'achat</th>
													<th class="text-white">Prix</th>
													<th class="text-white">Salle</th>
													<th class="text-white">Actions</th>
												</tr>
											</thead>
											<tbody id="machines" name="machines">

											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- Content end -->
				</div>
				<%@include file="template/footer.jsp"%>
			</div>
		</div>
	</div>
	
	<!-- Modal -->
<div class="modal fade" id="supprimermachine" tabindex="-1" aria-labelledby="supprimermachineLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="supprimermachineLabel">Suppression de machine</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       Voulez-vous bien supprimer cette machine ?
      </div>
      <div class="modal-footer m-auto">
        <button type="button" class="btn btn-secondary mr-2" data-dismiss="modal">Non</button>
        <button type="button" class="btn btn-success" onclick="supprimerMachine()">Oui</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modifiermachine" tabindex="-1" aria-labelledby="modifiermachineLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modifiermachineLabel">Modification</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
								<div class="card-body">
									<h4 class="card-title text-center">Modifier la machine</h4>
									<div class="row">
										<div class="form-group col-6">
											<label>Référence</label> 
											<input id="mreference" name="mreference" type="text" class="form-control p_input">
										</div>
										<div class="form-group col-6">
											<label>Marque</label> 
											<input id="mmarque" name="mmarque" type="text" class="form-control p_input">
										</div>
										<div class="form-group col-6">
											<label>Date d'achat</label> 
											<input id="mdateAchat" name="mdateAchat" type="date" class="form-control p_input">
										</div>
										<div class="form-group col-6">
											<label>Prix</label> 
											<input id="mprix" name="mprix" type="text" class="form-control p_input">
										</div>
										<div class="form-group col-12 mx-auto">
											<label>Salle</label> 
											<select id="msalle" name="msalle" class="form-control text-white">
												
											</select>
										</div>
									</div>
								</div>
							</div>
      <div class="modal-footer m-auto">
        <button type="button" class="btn btn-secondary mr-2" data-dismiss="modal">Annuler</button>
        <button type="submit" class="btn btn-success" onclick="modifiermachine()">Modifier</button>
      </div>
    </div>
  </div>
</div>
<script>
$(".deconnecter").on('click', function(event){
	$.ajax({
		url: "UserController",
		data: { op: "deconnecter" },
		type: 'POST',
		success: function(data, textStatus, jqXHR) {
			window.location.href = 'login.jsp';
		}
	});
});
$(document).ready(function() {
	$.ajax({
		url: "MachineController",
		data: { op: "load" },
		type: 'POST',
		success: function(data, textStatus, jqXHR) {
			console.log(data);
			remplirMachine(data);
		}
	});
});
var idMachine;
function load(x) {
	idMachine = x.parentNode.parentNode.cells[0].innerText;
	let reference = x.parentNode.parentNode.cells[1].innerText;
	let marque = x.parentNode.parentNode.cells[2].innerText;
	let dateAchat = x.parentNode.parentNode.cells[3].innerText;
	let prix = x.parentNode.parentNode.cells[4].innerText;
	let salle = x.parentNode.parentNode.cells[6].innerText;
	$("#mreference").val(reference);
	$("#mmarque").val(marque);
	
	//date format
	var now = new Date(dateAchat);
	var day = ("0" + now.getDate()).slice(-2);
	var month = ("0" + (now.getMonth() + 1)).slice(-2);
	var today = now.getFullYear()+"-"+(month)+"-"+(day) ;
	
	$("#mdateAchat").val(today);
	$("#mprix").val(prix);
	$('select[name^="msalle"] option[value="'+salle+'"]').attr("selected","selected");
}
function ajouterMachine(){
	let reference = $("#reference").val();
	let marque = $("#marque").val();
	let dateAchat = $("#dateAchat").val();
	let prix = $("#prix").val();
	let salle = $("#salle").val();
	if(reference !="" && marque !="" && dateAchat !="" && prix !="" && salle !=""){
		$.ajax({
			url: "MachineController",
			data: { ref:reference,
					marque:marque,
					dateAchat:dateAchat,
					prix:prix,
					salle:salle
				},
			type: 'POST',
			success: function(data, textStatus, jqXHR) {
				remplirMachine(data);
				$("#reference").val("");
				$("#marque").val("");
				$("#dateAchat").val("");
				$("#prix").val("");
				$("#salle").val(-1);
			}
		});
	}else
		$("#alertMachine").show();
}
function modifiermachine(){
	let reference = $("#mreference").val();
	let marque = $("#mmarque").val();
	let dateAchat = $("#mdateAchat").val();
	let prix = $("#mprix").val();
	let salle = $("#msalle").val();
	$.ajax({
		url: "MachineController",
		data: { op: "update",
			ref:reference,
			marque:marque,
			dateAchat:dateAchat,
			prix:prix,
			salle:salle,
			idMachine
			},
		type: 'POST',
		success: function(data, textStatus, jqXHR) {
			console.log(data);
			remplirMachine(data);
			$('#modifiermachine').modal('toggle');
		}
	});
}
function supprimerMachine(){
	console.log(idMachine);
	$.ajax({
		url: "MachineController",
		data: { op: "delete",
			idMachine: idMachine
			},
		type: 'POST',
		success: function(data, textStatus, jqXHR) {
			console.log(data);
			remplirMachine(data);
			$('#supprimermachine').modal('toggle');
		}
	});
}
function remplirSalleSelect(data){
	var salles = "<option value=-1>Selectionner la salle</option>";
	for(let i = 0; i < data.salles.length; i++){
		salles+='<option class="text-white" value="'+data.salles[i].id+'">'+data.salles[i].code+'</option>';
		}
	$("#salle").html(salles);
	$("#msalle").html(salles);
}
function remplirMachine(data) {
	var ligne = "";
	for (var i = 0; i < data.machines.length; i++) {
		ligne += '<tr><td>' + data.machines[i].id + '</td><td>' + data.machines[i].reference + '</td><td>' + data.machines[i].marque + '</td><td>'+ data.machines[i].dateAchat + '</td><td>'+ data.machines[i].prix +'</td><td>' + data.machines[i].salle.code +'</td><td hidden >' + data.machines[i].salle.id +'</td><td><button type="button" class="btn btn-inverse-warning btn-rounded mr-5" data-toggle="modal" data-target="#modifiermachine" onclick="load(this)">Modifier</button><button type="button" class="btn btn-inverse-danger btn-rounded" data-toggle="modal" data-target="#supprimermachine" onclick="load(this)">Supprimer</button></td></tr>';
	}
	remplirSalleSelect(data);
	$("#machines").html(ligne);
}
function hide(){
	$("#alertMachine").hide();
}
</script>
	<script src="assets/vendors/js/vendor.bundle.base.js"></script>
	<script src="assets/vendors/chart.js/Chart.min.js"></script>
	<script src="assets/vendors/progressbar.js/progressbar.min.js"></script>
	<script src="assets/vendors/jvectormap/jquery-jvectormap.min.js"></script>
	<script src="assets/vendors/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
	<script src="assets/vendors/owl-carousel-2/owl.carousel.min.js"></script>
	<script src="assets/js/off-canvas.js"></script>
	<script src="assets/js/hoverable-collapse.js"></script>
	<script src="assets/js/misc.js"></script>
	<script src="assets/js/settings.js"></script>
	<script src="assets/js/todolist.js"></script>
	<script src="assets/js/dashboard.js"></script>
</body>

</html>