page 50293 "Vote Transfer Post"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Votebook Transfer";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = NOT Rec.Posted;

                group(Transfer)
                {
                    Caption = 'Transfer Details';

                    field(No; Rec.No)
                    {
                        Editable = false;
                    }
                    field(Date; Rec.Date)
                    {
                    }
                    field("Budget Name"; Rec."Budget Name")
                    {
                    }
                    field(Amount; Rec.Amount)
                    {
                    }
                    field(Remarks; Rec.Remarks)
                    {
                        MultiLine = true;
                    }
                }
                group("Transfer From")
                {
                    Caption = 'Transfre From Details';

                    field("Source Vote"; Rec."Source Vote")
                    {
                    }
                    field("Source Vote Name"; Rec."Source Vote Name")
                    {
                    }
                    group(Control23)
                    {
                        ShowCaption = false;
                        Visible = false;

                        field("Source Dimension 1"; Rec."Source Dimension 1")
                        {
                        }
                        field("Source Dimension 2"; Rec."Source Dimension 2")
                        {
                        }
                    }
                }
                group("Transfer To")
                {
                    Caption = 'Transfer To Details';

                    field("Destination Vote"; Rec."Destination Vote")
                    {
                    }
                    field("Destination Vote Name"; Rec."Destination Vote Name")
                    {
                    }
                    group(Control30)
                    {
                        ShowCaption = false;
                        Visible = false;

                        field("Destination Dimension 1"; Rec."Destination Dimension 1")
                        {
                        }
                        field("Destination Dimension 2"; Rec."Destination Dimension 2")
                        {
                        }
                    }
                }
            }
            group("More Details")
            {
                Caption = 'More Details';
                Editable = NOT Rec.Posted;

                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Raised By"; Rec."Raised By")
                {
                    Editable = false;
                }
                field("Raised Date"; Rec."Raised Date")
                {
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    Editable = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Post)
            {
                Caption = 'Post Transfer';
                Image = TransferFunds;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    PaymentsManagement.PostVoteTransfer(Rec);
                end;
            }
        }
    }
    var
        PaymentsManagement: Codeunit "Payments Management";
}
