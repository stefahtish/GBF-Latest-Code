page 50216 "Item Transfer"
{
    PageType = Card;
    SourceTable = "Item Transfer";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Company From"; Rec."Company From")
                {
                    Editable = false;
                }
                field("Location From"; Rec."Location From")
                {
                }
                field(Item; Rec.Item)
                {
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field(Inventory; Rec.Inventory)
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity to Transfer';
                }
                label("Company Tranfering To:")
                {
                    Caption = 'Company Tranfering To:';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Company To"; Rec."Company To")
                {
                }
                field("Receiving Employee"; Rec."Receiving Employee")
                {
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Employee2.ChangeCompany(Rec."Company To");
                        Clear(EmployeeList);
                        //EmployeeList.ChangeCompany("Company To");
                        EmployeeList.SetTableView(Employee2);
                        EmployeeList.SetRecord(Employee2);
                        EmployeeList.LookupMode(true);
                        if EmployeeList.RunModal = ACTION::LookupOK then begin
                            EmployeeList.GetRecord(Employee2);
                            Rec."Receiving Name" := Employee2."First Name" + ' ' + Employee2."Middle Name" + ' ' + Employee2."Last Name";
                        end;
                    end;
                }
                field("Receiving Name"; Rec."Receiving Name")
                {
                    Editable = false;
                }
                field("Location To"; Rec."Location To")
                {
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Location.ChangeCompany(Rec."Company To");
                        Clear(LocationList);
                        //LocationList.ChangeComp("Company To");
                        LocationList.SetTableView(Location);
                        LocationList.SetRecord(Location);
                        LocationList.LookupMode(true);
                        if LocationList.RunModal = ACTION::LookupOK then begin
                            LocationList.GetRecord(Location);
                            Rec."Location To" := Location.Code;
                        end;
                    end;
                }
                field("Company Item"; Rec."Company Item")
                {
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Items.ChangeCompany(Rec."Company To");
                        Clear(ItemList);
                        //ItemList.ChangeCompany("Company To");
                        ItemList.SetTableView(Items);
                        ItemList.SetRecord(Items);
                        ItemList.LookupMode(true);
                        if ItemList.RunModal = ACTION::LookupOK then begin
                            ItemList.GetRecord(Items);
                            Rec."Company Item" := Items."No.";
                            Rec."Company Item Name" := Items.Description;
                        end;
                    end;
                }
                field("Company Item Name"; Rec."Company Item Name")
                {
                    Caption = 'Item Name';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Transfer Item")
            {
                Image = CreateInteraction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(Text001, true, Rec.Item, Rec.Description, Rec."Company To") = false then begin
                        exit;
                    end;
                    ProcurementMgt.TransferItem(Rec.Item, Rec.No, Rec."Company To", Rec."Company From", Rec.Quantity, Rec."Location To", Rec."Location From", Rec."Company Item");
                    Message(Text002, Rec.Item, Rec.Description, Rec."Company To");
                    CurrPage.Close;
                end;
            }
        }
    }
    var
        ProcurementMgt: Codeunit "Procurement Management";
        Text002: Label 'Item %1 - %2 Transfered Successfully to %3';
        Text001: Label 'Do you want to transfer Item %1 - %2 to %3';
        Employee2: Record Employee;
        EmployeeList: Page "Employee List";
        Items: Record Item;
        ItemList: Page "Item List";
        LocationList: Page "Location List";
        Location: Record Location;

    procedure ChangeCompany(CompTo: Text[250])
    var
        Employee: Record Employee;
    begin
    end;
}
