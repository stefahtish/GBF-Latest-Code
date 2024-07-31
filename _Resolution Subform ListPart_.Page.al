page 50872 "Resolution Subform ListPart"
{
    PageType = ListPart;
    SourceTable = "Resolution of Tasks Status";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

                field(Step; Rec."Step No.")
                {
                }
                field("Resolution Description"; Rec."Resolution Description")
                {
                }
                field("Resolution Status"; Rec."Resolution Status")
                {
                }
                field("Document No"; Rec."Document No")
                {
                }
                field("Header Status"; Rec."Header Status")
                {
                }
            }
        }
    }
    actions
    {
    }
}
