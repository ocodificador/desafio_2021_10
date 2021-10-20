<template>
  <h1>Desafio Web Developer</h1>
  <div id="app" class="container">
    <aside class="projects__list">
      <section v-if="errored">
        <p>
          Algo de errado aconteceu, não foi possível obter os dados, tente mais
          tarde
        </p>
      </section>

      <section v-else>
        <div v-if="loading">Carregando...</div>
        <div v-else>
          <table>
            <thead>
              <tr>
                <th>Projetos</th>
                <th>Data Início</th>
                <th>Data Fim</th>
                <th>% Completo</th>
                <th>Atrasado</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="project in projects" v-bind:key="project.id" v-on:click="getProject(project)">
                <td>{{ project.name }}</td>
                <td>{{ project.start_date }}</td>
                <td>{{ project.end_date }}</td>
                <td>{{ project.complete.toFixed(2) }}</td>
                <td>{{ project.delayed ? "Sim" : "Não" }}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>
    </aside>
    <div class="project__detail">
      <div>
        <input type="text" v-model="currentProject.name" />
        <input type="date" v-model="currentProject.start_date" />
        <input type="date" v-model="currentProject.end_date" />
        <div>
          <button v-on:click="newProject">Novo</button>
          <button v-on:click="saveProject(currentProject)">Gravar</button>
          <button v-on:click="deleteProject(currentProject)">Excluir</button>
          <button v-on:click="getProjects">Refresh</button>
          <button v-on:click="newActivity">Nova Atividade</button>
        </div>
      </div>
      <div class="activities__list">
        <table>
          <thead>
            <tr>
              <th>Atividades</th>
              <th>Data Início</th>
              <th>Data Fim</th>
              <th>Finalizada</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="activity in currentProject.activities" v-bind:key="activity.id">
              <td>{{ activity.name }}</td>
              <td>{{ activity.start_date }}</td>
              <td>{{ activity.end_date }}</td>
              <td>
                <input type="checkbox" v-model="activity.finished" />
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

const api = axios.create({
  baseURL: "http://0.0.0.0:3000",
  headers: {
    Accept: "application/json",
    "Content-Type": "application/json",
  },
});

export default {
  name: "App",
  data() {
    return {
      errored: false,
      loading: true,
      projects: null,
      currentProject: {
        name: null,
        startDate: null,
        endDate: null,
      },
    };
  },
  methods: {
    newProject() {
      this.currentProject = {
        id: null,
        name: null,
        startDate: null,
        endDate: null,
      };
    },
    getProjects() {
      api
        .get("/projects")
        .then((response) => (this.projects = response.data))
        .catch((error) => {
          console.log(error.response);
          alert(error.response.request.response);
          this.errored = true;
        })
        .finally(() => (this.loading = false));
      this.newProject();
    },
    getProject(project) {
      this.currentProject = project;
    },
    saveProject(project) {
      // Fazendo o Rails aceitar as atividades
      project.activities_attributes = project.activities;
      if (project.id == null) {
        api
          .post("/projects", project)
          .then((response) => {
            console.log(response);
            this.getProjects();
          })
          .catch(function(error) {
            console.log(error.response);
            alert(error.response.request.response);
            this.errored = true;
          });
      } else {
        api
          .patch(`/projects/${project.id}`, project)
          .then((response) => {
            console.log(response);
            this.getProjects();
          })
          .catch(function(error) {
            console.log(error.response);
            alert(error.response.request.response);
            this.errored = true;
          });
      }
    },
    deleteProject(project) {
      if (project.id == null) {
        alert("Nenhum projeto selecionado");
      } else {
        api
          .delete(`/projects/${project.id}`)
          .then((response) => {
            console.log(response);
            this.getProjects();
          })
          .catch(function(error) {
            console.log(error.response);
            alert(error.response.request.response);
            this.errored = true;
          });
      }
    },
  },
  mounted() {
    this.getProjects();
  },
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;

  margin: 1rem auto;
  padding: 1rem;  
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.26);
}

* {
  box-sizing: border-box;
}

h1 { text-align: center; }

body {
  margin: 0;
} 

button {
  margin-right: 5px;
}

label,
input {
  margin-bottom: 0.5rem;
  display: block;
  width: 100%;
}

label {
  font-weight: bold;
}

table {
  width: 100%;
  border-collapse: collapse;
  border-color: #ccc;
  border-spacing: 0;
  border-style: solid;
  border-width: 2px;
}

th {
  background-color: #f0f0f0;
  border-color: #ccc;
  border-style: solid;
  border-width: 2px;
  color: #333;
  font-family: Arial, sans-serif;
  font-size: 14px;
  font-weight: normal;
  overflow: hidden;
  padding: 10px 5px;
  word-break: normal;
}

td {
  background-color: #fff;
  border-color: #ccc;
  border-style: solid;
  border-width: 0px;
  color: #333;
  font-family: Arial, sans-serif;
  font-size: 14px;
  overflow: hidden;
  padding: 10px 5px;
  word-break: normal;
}

td:hover {
  background-color: gray;
  cursor: pointer;
}

.container {
  display: flex;
}

.projects__list {
  width: 60%;
  overflow: auto;
}

.project__detail {
  flex: 1;
  overflow: auto;

  margin-left: 1rem;
  padding: 10px 5px;

  border-collapse: collapse;
  border-color: #ccc;
  border-spacing: 0;
  border-style: solid;
  border-width: 2px;  
}

.activities__list {
  margin-top: 1rem;
  overflow: auto;
}
</style>
