<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Chraibi Admin</title>
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
					<div class="col-md-10 mx-auto grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title">Modifier votre profile</h4>
                    <p class="card-description">Les informations</p>
                    <div style="display:none" id="alert" class="alert alert-danger alert-dismissible fade show col-12" role="alert">
										  <strong>!</strong>
										  <button type="button" class="close" onclick="hide()">
										    <span aria-hidden="true">&times;</span>
										  </button>
										</div>
                      <div class="form-group">
                        <label for="nameUp">Nom complet</label>
                        <input type="text" class="form-control" id="nameUp" value="<%= request.getSession(false).getAttribute("nom") %>" placeholder="Nom complet">
                      </div>
                      <div class="form-group">
                        <label for="userUp">Nom d'utilisateur</label>
                        <input type="text" class="form-control" id="userUp" value="<%= request.getSession(false).getAttribute("user") %>" placeholder="Nom d'utilisateur">
                      </div>
                      <div class="form-group">
                        <label for="opassUp">Mot de passe actuel</label>
                        <input type="password" class="form-control" id="opassUp" placeholder="Ancien mot de passe">
                      </div>
                      <div class="form-group">
                        <label for="npassUp">Nouveau mot de passe</label>
                        <input type="password" class="form-control" id="npassUp" placeholder="Nouveau mot de passe">
                      </div>
                      
                      <button onclick="updateUser(<%= request.getSession(false).getAttribute("id") %>)" class="btn btn-success btn-block">Modifier</button>
                      
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
function updateUser(id){
	var nom = $("#nameUp").val();
	var user = $("#userUp").val();
	var opass = $("#opassUp").val();
	var npass = $("#npassUp").val();
	if(opass != "" && npass != "" && nom != "" && user != ""){
		if(opass == <%= request.getSession(false).getAttribute("pass") %>){
			$.ajax({
				url: "UserController",
				data: { op: "upUser",
						id:id,
						nom:nom,
						user:user,
						pass:npass
				},
				type: 'POST',
				success: function(data, textStatus, jqXHR) {
					if(data == "true")
						{
							toast("success","Profile modifier","Profile bien modifier");
							setTimeout(function() { 
								window.location.href = 'updateProfile.jsp';
							  }, 2000);
						}
						
					else
						toast("error","Erreur","Profile non modifier");
					hide();
				}
			});
		}
		else{
			$("#alert").html("<strong>!</strong>L'ancien mot de passe est incorrect<button type='button' class='close' onclick='hide()'><span aria-hidden='true'>&times;</span></button>");
			$("#alert").show();
		}
	}
	else{
		$("#alert").html("<strong>!</strong>Remplir tous les champs<button type='button' class='close' onclick='hide()'><span aria-hidden='true'>&times;</span></button>");
		$("#alert").show();
	}	
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

function hide(){
	$("#alert").hide();
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