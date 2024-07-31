page 51465 "Target Setup Lines"
{
    ApplicationArea = All;
    Caption = 'Target Setup Lines';
    PageType = ListPart;
    SourceTable = "Target Setup Lines";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                ShowCaption = false;

                field("SNo."; Rec."SNo.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Max Score"; Rec."Max Score")
                {
                    ToolTip = 'Specifies the value of the Max Score field.';
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        if Rec."Max Score" > 16 then Error('Max Score Should be less  than r Equal to 16 for 5 Targets Set');
                    end;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Performance Indicators")
            {
                Image = CampaignEntries;
                RunObject = page "Strategic Impl Initiative";
                RunPageLink = ObjectiveCode=field("SNo."), "Target No."=FIELD("Target No"), "Employee No."=field("Employee No"), "Appraisal Period"=field("Appraisal Period");
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean var
        HrSetup: Record "Human Resources Setup";
    begin
        HrSetup.Get();
        Rec."Max Score":=HrSetup."Target Max Score";
        Counter:=0;
    // Lines.Reset();
    // Lines.SetRange("Appraisal No", "Appraisal No");
    // Lines.SetRange("SNo.", "SNo.");
    // Lines.SetFilter(Description, '<>%1', '');
    // If Lines.FindFirst() then begin
    //     Counter := Lines.Count;
    //     if Counter > 5 then
    //         Error('Maxmum Traget Set is 5');
    // end;
    end;
    // trigger OnInsert()
    // var
    //     Lines: Record "Target Setup Lines";
    //     Counter: Integer;
    // begin
    //     Lines.Reset();
    //     Lines.SetRange("SNo.", "SNo.");
    //     Lines.SetRange("Appraisal No", "Appraisal No");
    //     If Lines.FindFirst() then begin
    //         Counter := Lines.Count;
    //         if Counter > 5 then
    //             Error('Maxmum Traget Set is 5');
    //     end;
    // end;
    var UnderReview: Boolean;
    UnderFurtherReview: Boolean;
    EmployeeAppraisal: Record "Employee Appraisal";
    Lines: Record "Target Setup Lines";
    Counter: Integer;
    IsEditable: Boolean;
    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;
    local procedure SetControlAppearance()
    begin
        UnderFurtherReview:=false;
        UnderReview:=false;
        EmployeeAppraisal.Reset();
        EmployeeAppraisal.SetRange("Target No", Rec."Target No");
        If EmployeeAppraisal.FindFirst()then case EmployeeAppraisal."Appraisal Status" of EmployeeAppraisal."Appraisal Status"::Review: begin
                UnderReview:=true;
            end;
            EmployeeAppraisal."Appraisal Status"::"Further Review": begin
                UnderFurtherReview:=true;
            end;
            end;
    end;
}
