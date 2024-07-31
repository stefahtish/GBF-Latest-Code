page 50521 "Relative Card"
{
    PageType = Card;
    SourceTable = "Employee Relative";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    Visible = false;
                }
                field("Dependant No"; Rec."Dependant No")
                {
                }
                field("Relative Code"; Rec."Relative Code")
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field("Birth Date"; Rec."Birth Date")
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("Relative's Employee No."; Rec."Relative's Employee No.")
                {
                    Visible = false;
                }
                field(Gender; Rec.Gender)
                {
                }
                field(Dependant; Rec.Dependant)
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
        }
    }
    var
        Text0001: Label 'Register To Infimary Data';
}
