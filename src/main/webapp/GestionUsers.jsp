<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Gestion des utilisateurs</title>
<script src="script/jquery-3.3.1.min.js" type="text/javascript"></script>
<link href="script/toastr.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="assets/vendors/mdi/css/materialdesignicons.min.css">
<link rel="stylesheet" href="assets/vendors/css/vendor.bundle.base.css">
<link rel="stylesheet" href="assets/vendors/jvectormap/jquery-jvectormap.css">
<link rel="stylesheet" href="assets/vendors/flag-icon-css/css/flag-icon.min.css">
<link rel="stylesheet" href="assets/vendors/owl-carousel-2/owl.carousel.min.css">
<link rel="stylesheet" href="assets/vendors/owl-carousel-2/owl.theme.default.min.css">
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
					<div class="card">
						<div class="card-body">
							<ul class="nav nav-tabs nav-tabs-solid nav-justified">
								<li class="nav-item"><a class="nav-link active bg-success" href="#solid-justified-tab1" data-toggle="tab">Gestion des utilisateurs</a></li>
			                    <li class="nav-item"><a class="nav-link bg-success" href="#solid-justified-tab2" data-toggle="tab">Gestion des comptes</a></li>
							</ul>
							
							<div class="tab-content">
								<div class="tab-pane show active" id="solid-justified-tab1">
		                        	<h4 class="card-title">Liste des utilisateurs</h4>
		                            <div class="table-responsive text-center">
										<table class="table">
											<thead>
												<tr>
													<th class="text-white">ID</th>
													<th class="text-white">Nom</th>
													<th class="text-white">Nom d'utilisateur</th>
													<th class="text-white">Role</th>
													<th class="text-white">Action</th>
												</tr>
											</thead>
											<tbody id="users" name="users">
											</tbody>
										</table>
									</div>
								</div>
								<div class="tab-pane" id="solid-justified-tab2">
									<div class="card">
										<div class="container">
									        <div class="row">
									            <div class="col-md-10 mx-auto text-center">
									                <h2>Générer un compte</h2>
									            </div>
									            <div style="display:none" id="alertMachine" class="alert alert-danger alert-dismissible fade show col-7 mx-auto" role="alert">
												  <strong>!</strong> Selectionner d'abord le role
												  <button type="button" class="close" onclick="hide()">
												    <span aria-hidden="true">&times;</span>
												  </button>
												</div>
									            <div class="col-md-7 mb-3 mx-auto">
									                <select id="role" name="role" class="form-control text-white">
														<option value="-1" >Selectionner le role</option>
														<option value="Administrateur" >Administrateur</option>
														<option value="Moderateur" >Moderateur</option>
													</select>
									            </div>
									            <div class="col-md-7 mx-auto">
									                <button type="button" class="btn btn-danger btn-block" onclick="makeAccount(10)">Générer</button>
									            </div>
									        </div>
								   		</div>
									    <div class="container">
									        <div class="row">
									            <div class="col-md-6 mx-auto">
									            	<div class="progress mt-4 mb-4">
														<div id="progress_bar" class="progress-bar progress-bar-striped progress-bar-animated bg-danger" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%"></div>
													</div>
									                <div class="row">
									                	<div class="col-6">
															<div class="input-group mb-2 mr-sm-2">
																<div class="input-group-prepend">
															    	<div class="input-group-text bg-dark">@</div>
															    </div>
															    <input id="gUsername" name="gUsername" disabled type="text" class="form-control text-black bg-dark" placeholder="Nom d'utilisateur">
															</div>
														</div>
														<div class="col-6">
															<div class="input-group mb-2 mr-sm-2">
																<input id="gPassword" name="gPassword" disabled type="text" class="form-control text-black bg-dark" placeholder="Mot de passe">
															</div>
														</div>
									            	</div>
									            </div>
									           	<div class="col-12 text-center">
									            	<button onclick="copyAccount()" class="btn btn-success btn-md">Copier</button>
									        	</div>
											</div>
										</div>
									</div>
									<h4 class="card-title">Liste des comptes generés</h4>
			                        <div class="table-responsive text-center">
										<table class="table">
											<thead>
												<tr>
													<th class="text-white">ID</th>
													<th class="text-white">Nom d'utilisateur</th>
													<th class="text-white">Mot de passe</th>
													<th class="text-white">Role</th>
													<th class="text-white">Etat</th>
												</tr>
											</thead>
											<tbody id="comptes" name="comptes">
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
		url: "UserController",
		data: { op: "loadAccounts" },
		type: 'POST',
		success: function(data, textStatus, jqXHR) {
			console.log(data);
			remplirComptes(data);
		}
	});
	$.ajax({
		url: "UserController",
		data: { op: "loadUsers" },
		type: 'POST',
		success: function(data, textStatus, jqXHR) {
			console.log(data);
			remplirUsers(data);
		}
	});
});

function generate(length) {
    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
      result += characters.charAt(Math.floor(Math.random() *  charactersLength));
   }
   return result;
}

function makeAccount(length)
{
	var role = $("#role").val();
	if(role != "-1"){
		var user = generate(length);
		var pass = generate(length);
		$.ajax({
			url: "UserController",
			data: { op: gen,
					user: user,
					pass: pass,
					role: role
			},
			type: 'POST',
			success: function(data, textStatus, jqXHR) {
				console.log(data);
				remplirComptes(data);
			}
		});
		$("#gUsername").val(user);
		$("#gPassword").val(pass);
		for(var i=0;i<length;i++)
		{
			$('#progress_bar').css('width', (i+1)*10 + "%");
		}
		setTimeout(function() { 
			$('#progress_bar').css('width', 0 + "%");
	    }, 1000);
	}
	else{
		$("#alertMachine").html("<strong>!</strong> Selectionner d'abord le role<button type='button' class='close' onclick='hide()'><span aria-hidden='true'>&times;</span></button>");
		$("#alertMachine").show();
	}
}

function remplirComptes(data){
	var ligne = "";
	for (var i = 0; i < data.length; i++) {
		ligne += '<tr><td>' + data[i].id + '</td><td>' + data[i].username + '</td><td>' + data[i].password + '</td><td>'+ data[i].role + '</td><td><button type="button" class="btn btn-inverse-success btn-rounded" onclick="copierLine(this)">Copier</button></td></tr>';
	}
	$("#comptes").html(ligne);
}

function remplirUsers(data){
	var ligne = "";
	for (var i = 0; i < data.length; i++) {
		if(data[i].etat == "-1")
			ligne += '<tr><td>' + data[i].id + '</td><td>' + data[i].nom + '</td><td>' + data[i].username + '</td><td>'+ data[i].role + '</td><td><button type="button" class="btn btn-inverse-success btn-rounded" onclick="on(this)">Activer</button></td></tr>';
		if(data[i].etat == "1")
			ligne += '<tr><td>' + data[i].id + '</td><td>' + data[i].nom + '</td><td>' + data[i].username + '</td><td>'+ data[i].role + '</td><td><button type="button" class="btn btn-inverse-danger btn-rounded" onclick="off(this)">Desactiver</button></td></tr>';
	}
	$("#users").html(ligne);
}
function on(x){
	var id = x.parentNode.parentNode.cells[0].innerText;
	$.ajax({
		url: "UserController",
		data: { op: "on",
				id:id	
		},
		type: 'POST',
		success: function(data, textStatus, jqXHR) {
			console.log(data);
			remplirUsers(data);
		}
	});
}

function off(x){
	var id = x.parentNode.parentNode.cells[0].innerText;
	$.ajax({
		url: "UserController",
		data: { op: "off",
				id:id	
		},
		type: 'POST',
		success: function(data, textStatus, jqXHR) {
			console.log(data);
			remplirUsers(data);
		}
	});
}

function toast(type,title,value){
	toastr.options = {
  		  "closeButton": true,
  		  "debug": false,
  		  "newestOnTop": false,
  		  "progressBar": true,
  		  "positionClass": "toast-top-right",
  		  "preventDuplicates": false,
  		  "onclick": null,
  		  "showDuration": "300",
  		  "hideDuration": "1000",
  		  "timeOut": "5000",
  		  "extendedTimeOut": "1000",
  		  "showEasing": "swing",
  		  "hideEasing": "linear",
  		  "showMethod": "fadeIn",
  		  "hideMethod": "fadeOut"
  		}
  toastr[type](value, title);
  $("#toast-container div").removeClass("toast");
  setTimeout(function() { 
	  $('.toast-success').css('opacity', '1');
  }, 500);
}

function copy(value){
	var $temp = $("<input>");
    $("body").append($temp);
    $temp.val(value).select();
    document.execCommand("copy");
    $temp.remove();
}

function copyAccount(){
	var value = $("#gUsername").val() + " : " + $("#gPassword").val();
	if(value != " : "){
		copy(value);
		toast("success","Compte generer","Bien copier");
	}
	else{
		$("#alertMachine").html("<strong>!</strong> Generer d'abord un compte<button type='button' class='close' onclick='hide()'><span aria-hidden='true'>&times;</span></button>");
		$("#alertMachine").show();
	}
}
function copierLine(x){
	var user = x.parentNode.parentNode.cells[1].innerText;
	var pass = x.parentNode.parentNode.cells[2].innerText;
	var value = user + " : " + pass;
	copy(value);
	toast("success","Copie","Bien copier");
}

function hide(){
	$("#alertMachine").hide();
}
</script>
	<script src="script/toastr.min.js"></script>
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