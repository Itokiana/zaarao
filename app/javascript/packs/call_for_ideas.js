function getCallForIdea(project_id = 0) {
    $.ajax({
        url: '/call_for_ideas',
        type: 'GET',
        dataType: 'script',
        data: { project_id: project_id }
    });
}