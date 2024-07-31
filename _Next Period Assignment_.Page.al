page 51302 "Next Period Assignment"
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Appraisal Lines";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Duties and Responsibility"; Rec."Duties and Responsibility")
                {
                }
                field("Agreed perfomance targets"; Rec."Agreed perfomance targets")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        EmployeeAppraisal: record "Employee Appraisal";

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GetHeader();
        Rec."Appraisee No" := EmployeeAppraisal."Employee No";
        Rec."Next Year Duties" := true;
    end;

    local procedure GetHeader()
    begin
        iF EmployeeAppraisal.Get(Rec."Appraisal No") then;
    end;
}
