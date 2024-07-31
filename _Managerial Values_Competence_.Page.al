page 50550 "Managerial Values/Competence"
{
    SourceTable = "Appraisal Competences";
    SourceTableView = where("Core Value/Competence"=Const("Core Managerial Values/Competence"));
    ApplicationArea = All;
    PageType = ListPart;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("SNo."; Rec."SNo.")
                {
                    ToolTip = 'Specifies the value of the SNo. field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    Editable = false;
                }
                field("Self Rating"; Rec."Self Rating")
                {
                    ToolTip = 'Specifies the value of the Self Rating field.';
                    ApplicationArea = All;
                }
                field("Does not Demonstrate"; Rec."Does not Demonstrate")
                {
                    ToolTip = 'Specifies the value of the Does not Demonstrate field.';
                    ApplicationArea = All;
                    Caption = 'Does not Demonstrate (Score 0 mark)';
                    Visible = UnderReview or UnderFurtherReview;
                }
                field("Fairly Demonstrates"; Rec."Fairly Demonstrates")
                {
                    ToolTip = 'Specifies the value of the Fairly Demonstrates field.';
                    ApplicationArea = All;
                    Caption = 'Fairly Demonstrates (Score 1 mark)';
                    Visible = UnderReview or UnderFurtherReview;
                }
                field(Demonstrates; Rec.Demonstrates)
                {
                    ToolTip = 'Specifies the value of the Demonstrates field.';
                    Caption = 'Demonstrates (Score 2 marks)';
                    ApplicationArea = All;
                    Visible = UnderReview or UnderFurtherReview;
                }
            }
        }
    }
    var UnderReview: Boolean;
    UnderFurtherReview: Boolean;
    EmployeeAppraisal: Record "Employee Appraisal";
    // trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    // var
    //     myInt: Integer;
    // begin
    //     "Core Value/Competence" := "Core Value/Competence"::"Core Managerial Values/Competence";
    // end;
    trigger OnOpenPage()
    begin
        SetControlAppearance();
    // CurrPage.Update();
    end;
    local procedure SetControlAppearance()
    begin
        UnderFurtherReview:=false;
        UnderReview:=false;
        EmployeeAppraisal.Reset();
        EmployeeAppraisal.SetRange("Appraisal No", Rec."Appraisal No.");
        If EmployeeAppraisal.FindFirst()then case EmployeeAppraisal."Appraisal Status" of EmployeeAppraisal."Appraisal Status"::Review: begin
                UnderReview:=true;
            end;
            EmployeeAppraisal."Appraisal Status"::"Further Review": begin
                UnderFurtherReview:=true;
            end;
            end;
    end;
}
