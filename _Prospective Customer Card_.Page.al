page 51319 "Prospective Customer Card"
{
    PageType = Card;
    SourceTable = "Prospective Customers";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("No."; Rec."No.")
                {
                    Enabled = false;
                }
                field(ApplicationDate; Rec.ApplicationDate)
                {
                    Caption = 'Registration Date';
                    Enabled = false;
                }
                field(Name; Rec.Name)
                {
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                }
                field("Customer No"; Rec."Customer No")
                {
                    //Enabled = false;
                }
                group("Company Address")
                {
                    field("Physical Address"; Rec."Physical Address")
                    {
                    }
                    field("E-mail"; Rec."E-mail")
                    {
                    }
                    field("Telephone No"; Rec."Telephone No")
                    {
                    }
                    field("Mobile No"; Rec."Mobile No")
                    {
                    }
                    field("Postal Address"; Rec."Postal Address")
                    {
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                    }
                    field(City; Rec.City)
                    {
                    }
                }
                group("Bank Account Details")
                {
                    field("KBA Bank Code"; Rec."KBA Bank Code")
                    {
                        Caption = 'Bank Code';
                    }
                    field("KBA Branch Code"; Rec."KBA Branch Code")
                    {
                        Caption = 'Branch Code';
                    }
                    field("Bank account No"; Rec."Bank account No")
                    {
                    }
                }
                field("Fax No"; Rec."Fax No")
                {
                }
                field("Registration No"; Rec."Registration No")
                {
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                Caption = 'Attachments';
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Submit)
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Submitted := true;
                    commit;
                end;
            }
        }
    }
    var
        ProcMgt: Codeunit "Procurement Management";
}
