page 50473 "Interview List"
{
    CardPageID = "Interview Card";
    PageType = List;
    Editable = false;
    SourceTable = "Applicant job applied";
    SourceTableView = WHERE(Qualified = CONST(true), Interviewed = FILTER(false));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
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
                field(Qualified; Rec.Qualified)
                {
                    Caption = 'Qualified';
                }
                field("Need Code"; Rec."Need Code")
                {
                }
                field(Job; Rec.Job)
                {
                }
                field(Interviewed; Rec.Interviewed)
                {
                }
            }
        }
    }
    actions
    {
    }
}
