page 50194 "Document Name"
{
    PageType = StandardDialog;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Control2)
            {
                ShowCaption = false;

                field(RejectComment; RejectComment)
                {
                    Caption = 'Document Description';
                }
            }
        }
    }
    actions
    {
    }
    var
        RejectComment: Text;

    procedure GetRejectComment(): Text
    begin
        exit(RejectComment);
    end;

    procedure SetRejectComment(Comment: Text)
    begin
        RejectComment := Comment;
    end;
}
