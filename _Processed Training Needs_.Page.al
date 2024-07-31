page 50578 "Processed Training Needs"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Training';
    SourceTable = "Training Need";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;

                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Training Objectives"; Rec."Training Objectives")
                {
                    MultiLine = true;
                }
                field(Provider; Rec.Provider)
                {
                    Caption = 'Training Provider';
                    Visible = false;
                }
                field("Provider Name"; Rec."Provider Name")
                {
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Duration Units"; Rec."Duration Units")
                {
                    Visible = false;
                }
                field(Duration; Rec.Duration)
                {
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Cost Of Training"; Rec."Cost Of Training")
                {
                    Editable = false;
                }
                field("Cost Of Training (LCY)"; Rec."Cost Of Training (LCY)")
                {
                    Editable = false;
                }
                field(Location; Rec.Location)
                {
                    Visible = false;
                }
                field("Country Code"; Rec."Country Code")
                {
                }
                field(Venue; Rec.Venue)
                {
                    Visible = false;
                }
                group(More)
                {
                    Caption = 'More Details';
                    Editable = false;

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        Visible = false;
                    }
                    field(DimVal1; Rec.DimVal1)
                    {
                        Caption = 'Name';
                        Visible = false;
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        Visible = false;
                    }
                    field(DimVal2; Rec.DimVal2)
                    {
                        Caption = '&Name';
                        Visible = false;
                    }
                    field(Status; Rec.Status)
                    {
                        Editable = false;
                    }
                    field("No. of Participants"; Rec."No. of Participants")
                    {
                    }
                    field("Total Cost"; Rec."Total Cost")
                    {
                        Visible = false;
                    }
                    field("Total PerDiem"; Rec."Total PerDiem")
                    {
                        Visible = false;
                    }
                }
            }
            group(Remarks)
            {
                Caption = 'Remarks';
                Editable = Rec."Status" = Rec."Status"::"Application";

                field(Control40; Rec.Remarks)
                {
                }
                group(Control23)
                {
                    ShowCaption = false;
                    Visible = false;

                    field(Qualification; Rec.Qualification)
                    {
                    }
                    field("Re-Assessment Date"; Rec."Re-Assessment Date")
                    {
                    }
                    field(Source; Rec.Source)
                    {
                    }
                    field("Need Source"; Rec."Need Source")
                    {
                    }
                    field(Post; Rec.Post)
                    {
                    }
                    field(Posted; Rec.Posted)
                    {
                    }
                    field("Department Code"; Rec."Department Code")
                    {
                    }
                }
            }
            part(Control41; "Training Needs Lines")
            {
                Editable = false;
                SubPageLink = "Document No." = FIELD(Code);
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Ready)
            {
                Caption = 'Set As Ready For Application';
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to set this need as ready for application ?', false) then begin
                        Rec.Status := Rec.Status::Application;
                        Rec.Modify;
                    end;
                end;
            }
            action(Close)
            {
                Caption = 'Close Need';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Application";

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to close this need?', false) then begin
                        Rec.TestField(Remarks);
                        Rec.Status := Rec.Status::Closed;
                        Rec.Modify;
                    end;
                end;
            }
            action(Reopen)
            {
                Caption = 'Reopen For Editing';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to reopen this need?', false) then begin
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                    end;
                end;
            }
            action("Training Participants")
            {
                Image = SocialSecurity;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Approved Trainings Subform";
                RunPageLink = "Training Need" = FIELD(Code), Status = FILTER(Released);
                RunPageMode = View;
            }
            action("Training Evaluations")
            {
                Image = SocialSecurity;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Training Evaluation List";
                RunPageLink = "Training Name" = FIELD(Code), Submitted = FILTER(true);
                RunPageMode = View;
            }
        }
    }
}
