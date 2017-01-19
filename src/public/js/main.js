fetch('http://localhost:9292/user', { credentials: 'same-origin' }).then((response) =>
    response.json()
).then((json) =>
    fetch('http://localhost:9292/reverse', {
        method: 'POST',
        'Content-Type': 'application/json',
        body: JSON.stringify({ message: json.name })
    })
    ).then((response) =>
        response.text()
    ).then((text) =>
        alert(text)
    );