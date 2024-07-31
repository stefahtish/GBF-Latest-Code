page 50444 "Appraisal Types"
{
    PageType = List;
    SourceTable = "Appraisal Type";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field(Closed; Rec.Closed)
                {
                }
                field("Max. Weighting"; Rec."Max. Weighting")
                {
                }
                field("Minimum Job Group"; Rec."Minimum Job Group")
                {
                }
                field("Maximum Job Group"; Rec."Maximum Job Group")
                {
                }
                field("Max. Score"; Rec."Max. Score")
                {
                }
                field("Use Template"; Rec."Use Template")
                {
                }
                field("Template Link"; Rec."Template Link")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(ClosePeriod)
            {
                Caption = 'Close Appraisal Period';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to close this period?', false) then begin
                        Rec.Closed := true;
                        Rec.Modify;
                    end;
                end;
            }
        }
    }
}
