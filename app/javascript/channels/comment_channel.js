import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
    connected() {
        // Called when the subscription is ready for use on the server
    },

    disconnected() {
        // Called when the subscription has been terminated by the server
    },

    received(data) {
      $('#comments-length').html(`
        ${data.comments_length}
      `);
    $(`#comments-${data.wyc}-${data.wyc_id}`).append(`
      <div class="media" id="comment${data.id}">
        <div class="float-left">
            <div class="avatar">
                <img class="card-img-100 rounded-circle d-flex z-depth-1 mr-1" width="50" height="50" src="${data.avatar_url}" alt="...">
            </div>
        </div>
        <div class="media-body">
            <div class="row">
                <div class="col">
                    <h4 class="media-heading">
                        ${data.fullname}
                        <small>&#xB7;${data.created_at}</small>
                    </h4>
                </div>
                <div class="col">
                  if (${data.current_user_comment}) {
                    <a href="javascript:;" class="close float-right" for="#popover${data.id}" data-toggle="tooltip" data-placement="bottom" title="<a href='/comments/${data.id}/edit' class='btn btn-outline-link m-0' ><i class='fa fa-edit'></i></a> <a href='javascript:;' class='btn btn-danger m-0' data-toggle='modal' data-target='#comment${data.id}-modal' ><i class='fa fa-trash-o'></i></a>" data-container="body"><i class="fa fa-ellipsis-h"></i></a>
                    <!-- small modal -->
                    <div class="modal fade" id="comment${data.id}-modal" tabindex="0" role="dialog">
                        <div class="modal-dialog modal-small" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="material-icons">clear</i></button>
                                </div>
                                <div class="modal-body text-center">
                                    <h5>Are you sure you want to do this? </h5>
                                </div>
                                <div class="modal-footer justify-content-center">
                                    <button type="button" class="btn btn-link" data-dismiss="modal">No way</button>
                                    <a href='/comments/${data.id}' data-method='DELETE' data-remote="true" class="remove btn btn-success btn-link" for="#comment${data.id}">Yes</a>
                                </div>
                            </div>
                        </div>
                    </div>
                  }
                </div>
            </div>
            <p>
                ${data.content}
            </p>
            <!-- <div class="media-footer">
                <a href="javascript:;" class="btn btn-primary btn-link float-right" rel="tooltip" title="Available soon">
                    <i class="material-icons">reply</i> Reply
                </a>
                <a href="javascript:;" class="btn btn-danger btn-link float-right">
                    <i class="material-icons">favorite</i> 243
                </a>
            </div> -->
        </div>
      </div>
    `);
    }
});