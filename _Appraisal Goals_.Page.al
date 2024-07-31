page 50584 "Appraisal Goals"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Appraisal Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // IndentationColumn = NameIndent;
                // // IndentationControls = "Key Responsibility";
                // field("Objective Code"; "Objective Code")
                // {
                //     Caption = 'Strategic Objective Code';
                //     ApplicationArea = All;
                // }
                // field("Key Responsibility"; "Key Responsibility")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Strategic Objective';
                //     Style = Strong;
                //     StyleExpr = NameEmphasize;
                // }
                // field("Initiative code"; "Initiative code")
                // {
                //     Caption = 'Strategy Code';
                //     ApplicationArea = All;
                // }
                // field(Description; Description)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Strategy';
                // }
                // field("Activity code"; "Activity code")
                // {
                //     ApplicationArea = All;
                // }
                // field("Key Indicators"; "Key Indicators")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Activities';
                // }
                // field(Task; Task)
                // {
                //     ApplicationArea = All;
                // }
                field("Duties and Responsibility"; Rec."Duties and Responsibility")
                {
                }
                field("Agreed perfomance targets"; Rec."Agreed perfomance targets")
                {
                    ApplicationArea = All;
                }
                field("Performance Rating"; Rec."Performance Rating")
                {
                    Visible = UnderReview;
                }
                // field("Actual targets"; "Actual targets")
                // {
                //     Visible = UnderReview;
                //     ApplicationArea = All;
                // }
                // field(Weighting; Weighting)
                // {
                //     Visible = UnderReview;
                //     ApplicationArea = All;
                //     //Caption = 'Expected % score (Which is 100% for each) (B)';
                //     trigger OnValidate()
                //     begin
                //         CurrPage.Update();
                //     end;
                // }
                // field("Employee's Marks"; "Employee's Marks")
                // {
                //     Visible = UnderReview;
                //     ApplicationArea = All;
                //     trigger OnValidate()
                //     begin
                //         CurrPage.Update();
                //     end;
                // }
                // field("Supervisor's Marks"; "Supervisor's Marks")
                // {
                //     Visible = UnderReview;
                //     ApplicationArea = All;
                //     trigger OnValidate()
                //     begin
                //         CurrPage.Update();
                //     end;
                // }
                // field("Total marks per target"; "Total marks per target")
                // {
                //     Visible = UnderReview;
                //     ApplicationArea = All;
                // }
                // field("Results Achieved Comments"; "Results Achieved Comments")
                // {
                //     Visible = FinalYearVisible;
                //     Caption = 'Appraiser''s comments';
                //     ApplicationArea = All;
                // }
                field("Appraisal No"; Rec."Appraisal No")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            // action(Indent)
            // {
            //     Caption = 'Manually Indent Appraisal Goals';
            //     Image = Indent;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     trigger OnAction()
            //     begin
            //         HRMgt.IndentAppraisalGoals("Appraisal No");
            //     end;
            // }
        }
    }
    // trigger OnAfterGetRecord()
    // begin
    //     SetControlAppearance;
    // NameIndent := Indentation;
    // NameEmphasize := "Appraisal Line Type" <> "Appraisal Line Type"::Objective;
    // end;
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        GetHeader;
        SetControlAppearance;
        // NameEmphasize := "Appraisal Line Type" <> "Appraisal Line Type"::Objective;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GetHeader;
        Rec."Employee No" := EmployeeAppraisal."Employee No";
        // NameEmphasize := "Appraisal Line Type" <> "Appraisal Line Type"::Objective;
    end;

    trigger OnOpenPage()
    begin
        GetHeader;
        SetControlAppearance;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
        HRMgt.GetAverageRating(Rec);
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
        //EmployeeAppraisal.SetRange(EmployeeAppraisal."Appraisal No", "Appraisal No");
        if EmployeeAppraisal.Get(Rec."Appraisal No") then;
    end;

    local procedure SetControlAppearance()
    begin
        GetHeader;
        if (EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Review) or (EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::"Further review") or (EmployeeAppraisal."AppraisalType" = EmployeeAppraisal."AppraisalType"::Q4) then
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
        // if (EmployeeAppraisal."AppraisalType" = EmployeeAppraisal."AppraisalType"::"Mid-Year") and (EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Review) then
        //     MidYearVisible := true
        // else
        //     MidYearVisible := false;
        // if EmployeeAppraisal."AppraisalType" = EmployeeAppraisal."AppraisalType"::"Final Year" then
        //     FinalYearVisible := true
        // else
        //     FinalYearVisible := false;
        // if EmployeeAppraisal.status  IN [EmployeeAppraisal.Status::Released,EmployeeAppraisal.Status::Open] then 
        //     CurrPage.editable=true;
        if EmployeeAppraisal.Status = EmployeeAppraisal.Status::Released then
            Approved := true
        else
            Approved := false;
    end;
}
