page 50848 "Resolution Subform"
{
    PageType = Listpart;
    SourceTable = "Resolution of Tasks Status";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

                field("Interaction Header No."; Rec."Interaction Header No.")
                {
                }
                field("Interation Reso. Code"; Rec."Interation Reso. Code")
                {
                }
                field("Step No."; Rec."Step No.")
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
                field("Assigned User From"; Rec."Assigned User From")
                {
                }
                field("Assigned Date From"; Rec."Assigned Date From")
                {
                }
                field("Assigned User To"; Rec."Assigned User To")
                {
                }
                field("Assigned Date To"; Rec."Assigned Date To")
                {
                }
                field("Action Taken"; Rec."Action Taken")
                {
                }
                field("Action Status"; Rec."Action Status")
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
