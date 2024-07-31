page 50618 "Training Needs Requisitions"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Training Needs Request";
    UsageCategory = Lists;
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Source Document No"; Rec."Source Document No")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                }
                field("Training Name"; Rec."Training Name")
                {
                    ApplicationArea = All;
                }
                field("Training area"; Rec."Training area")
                {
                    ApplicationArea = All;
                }
                field("Training Objectives"; Rec."Training Objectives")
                {
                    ApplicationArea = All;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = All;
                }
                field(Provider; Rec.Provider)
                {
                    ApplicationArea = All;
                }
                field("Need Source"; Rec."Need Source")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create Training Need")
            {
                Visible = Rec.Status = Rec.Status::New;
                Caption = 'Create a Training need';
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    TrainingNeeds: Record "Training Need";
                begin
                    TrainingNeeds.Init;
                    TrainingNeeds.Code:='';
                    TrainingNeeds."Need Source":=Rec."Need Source";
                    TrainingNeeds."Training Objectives":=Rec."Training Objectives";
                    TrainingNeeds.Insert(true);
                    PAGE.RUN(Page::"Training Needs", TrainingNeeds);
                    Rec."Need created":=true;
                    Rec.Status:=Rec.Status::Created;
                    Rec.Modify();
                end;
            }
            action(Reject)
            {
                Visible = Rec.Status = Rec.Status::New;
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Status:=Rec.Status::Rejected;
                    Rec.Modify();
                end;
            }
        }
    }
}
