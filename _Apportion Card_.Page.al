page 50283 "Apportion Card"
{
    PageType = Card;
    SourceTable = "Apportion Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    Caption = 'Created By';
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                }
            }
            part(Control7; "Apportion Lines")
            {
                SubPageLink = "No." = FIELD("No.");
                Visible = Rec."Type" = Rec."Type"::"By Entry No";
            }
            part(Control15; "Apportionment Totals")
            {
                SubPageLink = "No." = FIELD("No.");
                Visible = Rec."Type" <> Rec."Type"::" ";
            }
            part(Control13; "Apportion Lines-Multiple")
            {
                SubPageLink = "No." = FIELD("No.");
                Visible = Rec."Type" = Rec."Type"::"By Document No";
            }
            part(Control8; "Apportionment Allocation Lines")
            {
                SubPageLink = "Document No." = FIELD("No.");
                Visible = Rec."Type" <> Rec."Type"::" ";
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Process)
            {
                Image = PostApplication;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to process?', false) then begin
                        Apportionment.ProcessApportion(Rec);
                    end;
                    CurrPage.Close;
                end;
            }
            action(Post)
            {
                Visible = false;
            }
            action("Process & Post")
            {
                Image = ExecuteAndPostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    Apportionment.ProcessApportion(Rec);
                    Apportionment.PostApportion(Rec);
                end;
            }
        }
    }
    var
        Apportionment: Codeunit Apportionment;
}
