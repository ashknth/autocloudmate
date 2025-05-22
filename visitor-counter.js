// Replace with your actual API Gateway endpoint URL
const apiEndpoint = 'https://mil077ut81.execute-api.us-east-1.amazonaws.com/';

// Fetch the visitor count from the API
fetch(apiEndpoint)
    .then(response => response.json())  // Parse the JSON response
    .then(data => {
        const visitorCount = data.visitor_count;  // Extract the count from the response
        // Display the visitor count in the HTML element with id "visitor-count"
        document.getElementById("visitor-count").innerText = `Visitor count: ${visitorCount}`;
    })
    .catch(error => {
        console.error('Error fetching visitor count:', error);
        document.getElementById("visitor-count").innerText = "Failed to load visitor count.";
    });
