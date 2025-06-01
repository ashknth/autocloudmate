document.addEventListener("DOMContentLoaded", function () {
  const toggleButton = document.getElementById("theme-toggle");
  const root = document.documentElement;

  // Load previously selected theme
  if (localStorage.getItem("theme") === "dark") {
    root.setAttribute("data-theme", "dark");
  }

  toggleButton.addEventListener("click", function () {
    const currentTheme = root.getAttribute("data-theme");
    const newTheme = currentTheme === "dark" ? "light" : "dark";
    root.setAttribute("data-theme", newTheme);
    localStorage.setItem("theme", newTheme);
  });
});

fetch('https://9uzaj7kq49.execute-api.us-east-1.amazonaws.com/default/visitorcounter')
    .then(response => response.json())
    .then(data => {
    document.getElementById("visitorcounter").textContent = data["visitorcount"];
  })
