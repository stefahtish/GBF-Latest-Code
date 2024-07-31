page 51253 "Appraisal Goals Self"
{
    Caption = 'Appraisal goals from job description';
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Appraisal Lines-JD";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                IndentationColumn = NameIndent;
                IndentationControls = "Key Responsibility";

                field("Key Responsibility"; Rec."Key Responsibility")
                {
                    Caption = 'Goal';
                    Style = Strong;
                    StyleExpr = NameEmphasize;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Initiatives';
                    Visible = false;
                }
                field("Key Indicators"; Rec."Key Indicators")
                {
                    Caption = 'Activities';
                    Visible = false;
                }
                field("Appraisal Line Type"; Rec."Appraisal Line Type")
                {
                    trigger OnValidate()
                    begin
                        SetControlAppearance;
                        CurrPage.Update;
                    end;
                }
                field("Agreed Target Date"; Rec."Agreed Target Date")
                {
                    Caption = 'Individual Performance Targets';
                    Editable = LineEditable AND NOT UnderReview;
                }
                field(KPI; Rec.KPI)
                {
                    Caption = 'Key Perfomance Indicators';
                    Visible = false;
                }
                field(Weighting; Rec.Weighting)
                {
                    Editable = LineEditable AND Setting;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Mid-Year Appraisal"; Rec."Mid-Year Appraisal")
                {
                    Editable = LineEditable AND UnderReview AND MidYearVisible;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Final Self-Appraisal"; Rec."Final Self-Appraisal")
                {
                    Caption = 'Self-Appraisal Score';
                    Editable = LineEditable;
                    Visible = UnderReview;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Score/Points"; Rec."Score/Points")
                {
                    Caption = 'Appraiser''s Score';
                    Editable = LineEditable;
                    Visible = UnderReview;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Results Achieved Comments"; Rec."Results Achieved Comments")
                {
                    Caption = 'Justification';
                    Editable = LineEditable;
                    Visible = Approved;
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
        Setting: Boolean;
        Approved: Boolean;
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
        if (EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Review) then //or (EmployeeAppraisal.Type = EmployeeAppraisal.Type::"Final Year") then
            UnderReview := true
        else
            UnderReview := false;
        if EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Setting then
            Setting := true
        else
            Setting := false;
        if EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Completed then
            Completed := true
        else
            Completed := false;
        /*if EmployeeAppraisal.Type = EmployeeAppraisal.Type::"Mid-Year" then
            MidYearVisible := true
        else
            MidYearVisible := false;

        if EmployeeAppraisal.Type = EmployeeAppraisal.Type::"Final Year" then
            FinalYearVisible := true
        else
            FinalYearVisible := false;
            */
        if EmployeeAppraisal.Status = EmployeeAppraisal.Status::Released then
            Approved := true
        else
            Approved := false;
    end;
}
