page 50586 "Appraisal work related attr"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Appraisal - attributes";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AttributeCode; Rec.AttributeCode)
                {
                }
                field(Attribute; Rec.Attribute)
                {
                }
                field("Indicator code"; Rec."Indicator code")
                {
                }
                field(Indicator; Rec.Indicator)
                {
                }
                field(Rating; Rec.Rating)
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Expected rating attributes"; Rec."Expected rating attributes")
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }
    actions
    {
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        GetHeader;
        SetControlAppearance;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GetHeader;
    end;

    trigger OnOpenPage()
    begin
        GetHeader;
        SetControlAppearance;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
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
        if EmployeeAppraisal.Get(Rec."Appraisal No.") then;
    end;

    local procedure SetControlAppearance()
    begin
        GetHeader;
        if (EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Review) or (EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::"Further review") then
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
        if EmployeeAppraisal.Status = EmployeeAppraisal.Status::Released then
            Approved := true
        else
            Approved := false;
    end;
}
