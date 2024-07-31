page 50530 "Completed Interviews-Failed"
{
    CardPageID = "Interview Card";
    PageType = List;
    SourceTable = "Applicant job applied";
    ApplicationArea = All;

    // SourceTableView = WHERE(Qualified = CONST(true),
    //                         Interviewed = FILTER(true), "Failed Interview" = const(true));
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
                {
                }
                field(Name; Rec.Name)
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
