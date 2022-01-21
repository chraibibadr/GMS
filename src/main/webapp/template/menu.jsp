<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<nav class="sidebar sidebar-offcanvas" id="sidebar">
	<div class="sidebar-brand-wrapper d-none d-lg-flex align-items-center justify-content-center fixed-top">
		<a class="sidebar-brand brand-logo" href="index.jsp">
			<h1 class="text-center text-white" style="font-size: 35px;font-weight: 400;letter-spacing: 12px;text-decoration: none;padding-top: 5px;">CHRAIBI</h1>
		</a>
		<a class="sidebar-brand brand-logo-mini" href="index.jsp">
			<img src="assets/images/logo-mini.svg" alt="logo">
		</a>
	</div>
	<ul class="nav">
		<li class="nav-item profile">
			<div class="profile-desc">
				<div class="profile-pic">
					<div class="count-indicator">
						<img class="img-xs rounded-circle "
							src="assets/images/faces/face15.jpg" alt=""> <span
							class="count bg-success"></span>
					</div>
					<div class="profile-name">
						<h5 class="mb-0 font-weight-normal"><%= request.getSession(false).getAttribute("nom") %></h5>
						<span><%= request.getSession(false).getAttribute("role") %></span>
					</div>
				</div>
				<a href="#" id="profile-dropdown" data-toggle="dropdown"><i
					class="mdi mdi-dots-vertical"></i></a>
				<div
					class="dropdown-menu dropdown-menu-right sidebar-dropdown preview-list"
					aria-labelledby="profile-dropdown">
					<a href="updateProfile.jsp"" class="dropdown-item preview-item">
						<div class="preview-thumbnail">
							<div class="preview-icon bg-dark rounded-circle">
								<i class="mdi mdi-settings text-primary"></i>
							</div>
						</div>
						<div class="preview-item-content">
							<p class="preview-subject ellipsis mb-1 text-small">Profile</p>
						</div>
					</a>
				</div>
			</div>
		</li>
		<li class="nav-item nav-category"><span class="nav-link">Menu</span>
		</li>
		<li class="nav-item menu-items"><a class="nav-link"
			href="index.jsp"> <span class="menu-icon"> <i
					class="mdi mdi-speedometer"></i>
			</span> <span class="menu-title">Tableau de bord</span>
		</a></li>
		<li class="nav-item menu-items"><a class="nav-link"
			href="GestionMachines.jsp"> <span
				class="menu-icon"> <i class="mdi mdi-laptop"></i>
			</span> <span class="menu-title">Les machines</span>
		</a></li>
		<li class="nav-item menu-items"><a class="nav-link"
			href="GestionSalles.jsp"> <span
				class="menu-icon"> <i class="mdi mdi-table-edit"></i>
			</span> <span class="menu-title">Les salles</span>
		</a></li>
		<li class="nav-item menu-items">
            <a class="nav-link collapsed" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
              <span class="menu-icon">
                <i class="mdi mdi-magnify"></i>
              </span>
              <span class="menu-title">Recherche</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="ui-basic" style="">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="MachineBySalle.jsp">Par salle</a></li>
                <li class="nav-item"> <a class="nav-link" href="MachinesBetweenDates.jsp">Par dates</a></li>
              </ul>
            </div>
          </li>
		<li <%= request.getSession(false).getAttribute("hidden") %> class="nav-item menu-items"><a class="nav-link"
			href="GestionUsers.jsp"> <span
				class="menu-icon"> <i class="mdi mdi-account"></i>
			</span> <span class="menu-title">Les utilisateurs</span>
		</a></li>
	</ul>
</nav>