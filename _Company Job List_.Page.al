page 50396 "Company Job List"
{
    CardPageID = "Company Job Card";
    PageType = List;
    SourceTable = "Company Job";
    Caption = 'Staff Establishment';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job ID"; Rec."Job ID")
                {
                }
                field("Job Description"; Rec."Job Description")
                {
                }
                field("No of Posts"; Rec."No of Posts")
                {
                }
                field("Occupied Position"; Rec."Occupied Position")
                {
                }
                field(Vacancy; Rec.Vacancy)
                {
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        //  HRManagement.GetVacantPositions(Rec);
    end;

    var
        HRManagement: Codeunit "HR Management";
}
