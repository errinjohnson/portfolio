document.getElementById('activitiesForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const activityLogID = document.getElementById('activityLogID').value;
    const activityType = document.getElementById('activityType').value;
    const description = document.getElementById('description').value;

    if (activityLogID && activityType) {
        displayActivity(activityLogID, activityType, description);
        document.getElementById('activitiesForm').reset(); // Reset the form fields after submission
        document.getElementById('description').value = ''; // Clear description manually as it is readonly
    } else {
        alert('Please fill in all required fields.');
    }
});

function displayActivity(logID, type, desc) {
    const listItem = document.createElement('li');
    listItem.textContent = `Log ID: ${logID}, Type: ${type}, Description: ${desc}`;
    listItem.className = 'list-group-item';
    document.getElementById('activitiesList').appendChild(listItem);
}

function updateDescription() {
    const descriptions = {
        "Job Search": "Activities related to searching for job opportunities including attending job fairs, submitting applications, and networking.",
        "Resume Building": "Preparation and optimization of a resume document to better appeal to potential employers.",
        "On-boarding": "Processes and tasks involved in integrating a new employee into the company, such as orientation and training."
    };
    const activityType = document.getElementById('activityType').value;
    document.getElementById('description').value = descriptions[activityType] || '';
}