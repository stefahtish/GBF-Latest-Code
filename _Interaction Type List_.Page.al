page 50852 "Interaction Type List"
{
    PageType = List;
    SourceTable = "Interaction Type";
    SourceTableView = SORTING("Interaction Type") ORDER(Ascending);
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                    ToolTip = 'This is the unique code defining the Interaction Case';
                }
                field(Description; Rec.Description)
                {
                }
                field("Interaction Type"; Rec."Interaction Type")
                {
                    ToolTip = 'Specifies the Type of Interaction that can occur';
                }
                field("Documents Can Be Attached"; Rec."Documents Can Be Attached")
                {
                }
                field("Exit Reason"; Rec."Exit Reason")
                {
                    Caption = 'Linked Exit Reason';
                    ToolTip = 'Selects the Type of Exit that can be linked to the Case/Interaction Raised when the Case/Interaction raised is a Lodge Claim';
                }
            }
        }
    }
    actions
    {
    }
}
