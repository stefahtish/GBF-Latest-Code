page 50520 "Employee Relative Change Reque"
{
    PageType = Card;
    SourceTable = "Next of Kin Change Request";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Dependant No"; Rec."Dependant No")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("Birth Date"; Rec."Birth Date")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Relative Code"; Rec."Relative Code")
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Import dependants")
            {
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    // CLEAR(ImportDependants);
                    // ImportDependants.RUN;
                end;
            }
        }
    }
}
