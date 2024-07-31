page 50592 "Appraisal Goals-Completed"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Appraisal Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;

                field("Objective Code"; Rec."Objective Code")
                {
                    Caption = 'Strategic objecive code';
                }
                field("Key Responsibility"; Rec."Key Responsibility")
                {
                    Caption = 'Strategic Objectives';
                    Style = Strong;
                    StyleExpr = NameEmphasize;
                }
                field("Initiative code"; Rec."Initiative code")
                {
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Initiatives';
                }
                field("Activity code"; Rec."Activity code")
                {
                }
                field("Key Indicators"; Rec."Key Indicators")
                {
                    Caption = 'Activities';
                }
                field("FY Target"; Rec."FY Target")
                {
                }
                field(Weighting; Rec.Weighting)
                {
                }
                field("Final Self-Appraisal"; Rec."Final Self-Appraisal")
                {
                    Caption = 'Perfomance Rating Employee';

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Score/Points"; Rec."Score/Points")
                {
                    Caption = 'Perfomance Rating Supervisor';

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Results Achieved Comments"; Rec."Results Achieved Comments")
                {
                    Caption = 'Remarks';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Indent)
            {
                Caption = 'Manually Indent Appraisal Goals';
                Image = Indent;

                trigger OnAction()
                begin
                    HRMgt.IndentAppraisalGoals(Rec."Appraisal No");
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
        NameIndent := Rec.Indentation;
        NameEmphasize := Rec."Appraisal Line Type" <> Rec."Appraisal Line Type"::Objective;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        NameEmphasize := Rec."Appraisal Line Type" <> Rec."Appraisal Line Type"::Objective;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GetHeader;
        Rec."Employee No" := EmployeeAppraisal."Employee No";
        NameEmphasize := Rec."Appraisal Line Type" <> Rec."Appraisal Line Type"::Objective;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance;
    end;

    var
        [InDataSet]
        NoEmphasize: Boolean;
        [InDataSet]
        NameEmphasize: Boolean;
        LineEditable: Boolean;
        UnderReview: Boolean;
        Completed: Boolean;
        MidYearVisible: Boolean;
        FinalYearVisible: Boolean;
        HRMgt: Codeunit "HR Management";
        [InDataSet]
        NameIndent: Integer;
        EmployeeAppraisal: Record "Employee Appraisal";

    local procedure GetHeader()
    begin
        EmployeeAppraisal.SetRange(EmployeeAppraisal."Appraisal No", Rec."Appraisal No");
        if EmployeeAppraisal.FindFirst then;
    end;

    local procedure SetControlAppearance()
    begin
        GetHeader;
        if Rec."Appraisal Line Type" = Rec."Appraisal Line Type"::Objective then
            LineEditable := true
        else
            LineEditable := false;
        if EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Review then
            UnderReview := true
        else
            UnderReview := false;
        if EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Completed then
            Completed := true
        else
            Completed := false;
        //if EmployeeAppraisal.Type = EmployeeAppraisal.Type::"Mid-Year" then
        //MidYearVisible := true
        //else
        //MidYearVisible := false;
        //if EmployeeAppraisal.Type = EmployeeAppraisal.Type::"Final Year" then
        //FinalYearVisible := true
        //else
        //FinalYearVisible := false;
    end;
}
