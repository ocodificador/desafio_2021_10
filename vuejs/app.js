Vue.createApp({
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
      axios
        .get("http://0.0.0.0:3000/projects")
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
      if (project.id == null) {
        axios
          .post("http://127.0.0.1:3000/projects", project)
          .then((response) => {
            this.getProjects();
          })
          .catch(function (error) {
            console.log(error.response);
            alert(error.response.request.response);
            this.errored = true;
          });
      } else {
        axios
          .patch(`http://127.0.0.1:3000/projects/${project.id}`, project)
          .then((response) => {
            this.getProjects();
          })
          .catch(function (error) {
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
        axios
          .delete(`http://127.0.0.1:3000/projects/${project.id}`)
          .then((response) => {
            this.getProjects();
          })
          .catch(function (error) {
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
}).mount("#app");
