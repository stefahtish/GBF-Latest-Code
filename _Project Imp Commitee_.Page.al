page 51344 "Project Imp Commitee"
{
    PageType = ListPart;
    Caption = 'Implementation Committee';
    SourceTable = "ProjectManagementImplCommittee";
    ApplicationArea = All;

    //AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                    visible = false;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ToolTip = 'Specifies the value of the Full Name field.';
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ToolTip = 'Specifies the value of the Contact field.';
                    ApplicationArea = All;
                }
                field("Email Address"; Rec."Email Address")
                {
                    ToolTip = 'Specifies the value of the Email Address field.';
                    ApplicationArea = All;
                }
                field("Institution/Organization Name"; Rec."Institution/Organization Name")
                {
                    ToolTip = 'Specifies the value of the Institution/Organization Name field.';
                    ApplicationArea = All;
                    Caption = 'Insitution/Organization';
                }
            }
        }
    }
}
