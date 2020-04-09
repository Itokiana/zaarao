function getRatings(idea_id = 0, project_id = 0) {
    $.ajax({
        url: '/ratings',
        type: 'GET',
        dataType: 'script',
        data: { idea_id: idea_id, project_id: project_id }
    });
}
