page 50459 "Vacant Positions"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Company Job";
    SourceTableView = WHERE(Vacancy = FILTER(> 0));
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
                field("Job Designation"; Rec."Job Description")
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
                    Caption = 'Variance';
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        HRManagement.GetVacantPositions(Rec);
    end;

    var
        HRManagement: Codeunit "HR Management";
}
